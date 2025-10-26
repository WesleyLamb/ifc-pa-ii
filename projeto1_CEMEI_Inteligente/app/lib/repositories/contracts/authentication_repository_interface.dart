import '../../models/models.dart';

abstract class AuthenticationRepositoryInterface {
  Future<User> auth({
    required String email,
    required String password
    });
}