import 'package:app/constants/strings.dart';
import 'package:app/models/user.dart';
import 'package:app/services/api_service.dart';
import 'package:app/utils/api_request.dart' as ApiRequest;
import 'package:app/utils/storage.dart' as Storage;
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  User? _authUser;
  bool _isLoading = true;

  User? get authUser => _authUser;
  bool get isAuthenticated => _authUser != null;
  bool get isLoading => _isLoading;

  // Inicializar verificando se há usuário logado
  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    _authUser = await tryGetAuthUser();

    _isLoading = false;
    notifyListeners();
  }

  Future<User?> tryGetAuthUser() async {
    // Se o tcho já logou antes, o refresh token estará preenchido
    // Se não logou ainda, deve cair na tela inicial

    final jwt = await Storage.get(AppStrings.refreshTokenStorageKey);
    if (jwt == null) {
      return null;
    }

    return await getAuthUser();
  }

  Future<User> getAuthUser() async {
    var user = await getUser('me');

    _authUser = user;
    notifyListeners();
    return user;
  }

  Future<void> token(String email, String password) async {
    var response = await ApiRequest.post(
      'oauth/token',
      data: {
        "grant_type": "password",
        "client_id": AppStrings.clientId,
        "client_secret": AppStrings.clientSecret,
        "username": email,
        "password": password,
        "scope": "*",
      },
    );

    // Se o retorno http acima for diferente de 2XX, ele disparará um exception. Caso contrário, o retorno é um usuário logado

    final accessToken = response['access_token'];
    final refreshToken = response['refresh_token'];

    Storage.set(AppStrings.accessTokenStorageKey, accessToken);
    Storage.set(AppStrings.refreshTokenStorageKey, refreshToken);

    // ApiService.setAccessToken(accessToken);

    // Buscar dados do usuário após login
    await getAuthUser();
  }

  Future<void> refreshToken() async {
    // Não tá funcionando, revisar backend
    var response = await ApiRequest.post(
      'oauth/token',
      data: {
        "grant_type": "refresh_token",
        "client_id": AppStrings.clientId,
        "client_secret": AppStrings.clientSecret,
        "refresh_token": await Storage.get(AppStrings.refreshTokenStorageKey),
        "scope": "*",
      },
    );

    final accessToken = response['access_token'];
    Storage.set(AppStrings.accessTokenStorageKey, accessToken);
    // ApiService.setAccessToken(accessToken);
  }

  Future<User> getUser(String uuid) async {
    var response = await ApiRequest.get('api/v1/users/$uuid');

    return User.fromJson(response['data']);
  }

  Future<void> logout() async {
    try {
      _authUser = null;
      notifyListeners();

      await Storage.remove(AppStrings.accessTokenStorageKey);
      await Storage.remove(AppStrings.refreshTokenStorageKey);
      
    } catch (e, stackTrace) {
      _authUser = null;
      notifyListeners();
    }
  }

  Future<User> register(String name, String email, String password, String passwordConfirmation) async {
    return await ApiService.register(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
  }
}