import 'package:app/constants/strings.dart';
import 'package:app/models/user.dart';
import 'package:app/utils/api_request.dart' as ApiRequest;
import 'package:app/utils/storage.dart' as Storage;

class AuthProvider {
  late User _authUser;

  User get authUser => _authUser;

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
    Storage.set(AppStrings.accessTokenStorageKey, response['access_token']);
    Storage.set(AppStrings.refreshTokenStorageKey, response['refresh_token']);
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

    Storage.set(AppStrings.accessTokenStorageKey, response['access_token']);
  }

  Future<User> getUser(String uuid) async {
    var response = await ApiRequest.get('api/v1/users/$uuid');

    return User.fromJson(response['data']);
  }
}
