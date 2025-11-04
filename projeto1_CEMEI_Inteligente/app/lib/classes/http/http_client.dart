import 'package:http/http.dart' as http;

class HttpClient {
  Future<http.Response> request(
    Uri url,
    String method,
    Map<String, String>? requestHeaders,
    Map<String, dynamic>? requestBody,
  ) {
    Future<http.Response> response;

    switch (method.toLowerCase()) {
      case 'get':
        response = http.get(url, headers: requestHeaders);
        break;
      case 'post':
        response = http.post(url, headers: requestHeaders, body: requestBody);
        break;
      case 'put':
        response = http.put(url, headers: requestHeaders, body: requestBody);
        break;
      case 'patch':
        response = http.patch(url, headers: requestHeaders, body: requestBody);
        break;
      case 'delete':
        response = http.delete(url, headers: requestHeaders);
        break;
      default:
        throw FormatException(
          "Parameter method should be one of get,post,put,patch,delete. ${method.toLowerCase()} given",
        );
    }
    return response;
  }
}
