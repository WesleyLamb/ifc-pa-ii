import 'package:app/constants/strings.dart';
import 'package:app/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:app/utils/api_request.dart' as ApiRequest;

class AuthProvider {
  late User _authUser;

  User get authUser => _authUser;

  Future<User?> tryGetAuthUser() async {
    const storage = FlutterSecureStorage();
    final jwt = await storage.read(key: AppStrings.accessTokenStorageKey);
    if (jwt == null) {
      return null;
    }

    var user = await getUser('me');

    _authUser = user;
    return user;
  }

  Future<User> getUser(String uuid) async {
    var response = await ApiRequest.get('users/$uuid');

    return User.fromJson(response['data']);
  }
}
