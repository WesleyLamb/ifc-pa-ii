import 'package:app/dtos/requests/contracts/request_dto.dart';

class TokenRequestDto implements RequestDto {
  final String email;
  final String password;

  TokenRequestDto({required this.email, required this.password});

  @override
  Map toJson() {
    return {'email': email, 'password': password};
  }
}
