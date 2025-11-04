import 'package:app/models/auth.dart';
import 'package:app/models/user.dart';

abstract class AuthenticationRepositoryInterface {
  Future<Auth> auth({required String email, required String password});
  Future<User> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  });
}
