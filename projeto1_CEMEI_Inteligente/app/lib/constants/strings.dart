class AppStrings {
  // AppStrings._();

  static const String appName = 'CEMEI Inteligente';
  static const String host = 'http://192.168.0.11';

  static const String accessTokenStorageKey = 'auth_accessToken';
  static const String refreshTokenStorageKey = "auth_refreshToken";
  static const String emailStorageKey = 'auth_email';

  static const String clientId = String.fromEnvironment('CLIENT_ID');
  static const String clientSecret = String.fromEnvironment('CLIENT_SECRET');
}
