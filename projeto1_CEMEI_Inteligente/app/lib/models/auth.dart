class Auth {
  String tokenType;
  late DateTime expiration;
  String accessToken;
  String? refreshToken;

  Auth(this.tokenType, int expiresIn, this.accessToken, this.refreshToken) {
    expiration = DateTime.now().add(Duration(seconds: expiresIn));
  }
}
