import 'package:app/classes/http/http_client.dart';
import 'package:app/models/kid.dart';
import 'package:app/repositories/contracts/kids_repository_interface.dart';

class KidRepository implements KidsRepositoryInterface {
  @override
  Future<Kid> index({int page = 1, int perPage = 25}) async {
    // HttpClient http = HttpClient();

    // final response = await http.request(
    //   Uri(
    //     host: 'http://cemeiluciagrazziotin.sc.gov.br/api/v1/kids',
    //     queryParameters: {
    //       'per_page': perPage as String,
    //       'page': page as String,
    //     },
    //   ),
    //   'post',
    //   ,
    //   {
    //     'grant_type': 'password',
    //     'client_id': '9fc62001-8c71-42e1-9622-068a8f77ddea',
    //     'client_secret': 'qmROhxhS8QtvZi5eY2fIKWdo9NzBPsbF0wWXqoUb',
    //     'username': email,
    //     'password': password,
    //     'scope': '*',
    //   },
    // );

    // switch (jsonDecode(response.body) as Map<String, dynamic>) {
    //   case {
    //     'token_type': String tokenType,
    //     'expires_in': int expiresIn,
    //     'access_token': String accessToken,
    //     'refresh_token': String? refreshToken,
    //   }:
    //     return Auth(tokenType, expiresIn, accessToken, refreshToken);
    //   default:
    //     throw FormatException("Invalid response");
    // }

    // TODO: implement index
    throw UnimplementedError();
  }
}
