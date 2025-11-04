import 'dart:convert';

import 'package:app/classes/http/http_client.dart';
import 'package:app/models/auth.dart';
import 'package:app/models/user.dart';

import 'contracts/authentication_repository_interface.dart';

class AuthenticationRepository implements AuthenticationRepositoryInterface {
  @override
  Future<Auth> auth({required String email, required String password}) async {
    HttpClient http = HttpClient();

    final response = await http.request(
      Uri.parse("http://cemeiluciagrazziotin.sc.gov.br/oauth/token"),
      'post',
      null,
      {
        'grant_type': 'password',
        'client_id': '9fc62001-8c71-42e1-9622-068a8f77ddea',
        'client_secret': 'qmROhxhS8QtvZi5eY2fIKWdo9NzBPsbF0wWXqoUb',
        'username': email,
        'password': password,
        'scope': '*',
      },
    );

    switch (jsonDecode(response.body) as Map<String, dynamic>) {
      case {
        'token_type': String tokenType,
        'expires_in': int expiresIn,
        'access_token': String accessToken,
        'refresh_token': String? refreshToken,
      }:
        return Auth(tokenType, expiresIn, accessToken, refreshToken);
      default:
        throw FormatException("Invalid response");
    }
  }

  @override
  Future<User> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
