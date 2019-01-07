import 'package:http/http.dart' as http;
import 'dart:convert';

class SmaSDK {
  final String baseUrl;
  final String clientSecret;
  final String clientId;
  Token token;

  SmaSDK({this.baseUrl, this.clientSecret, this.clientId});

  Future<Token> getAccessToken() async {
    http.Response response = await http.post("${baseUrl}/oauth/token", body: {
      "client_id": clientId,
      "client_secret": clientSecret,
      "scope": "*",
      "grant_type": "client_credentials",
    }, headers: {
      "accept": "application/json"
    });

    dynamic tokenResponse = jsonDecode(response.body);
    DateTime now = DateTime.now();
    now = now.add(Duration(seconds: tokenResponse["expires_in"]));

    return Token(
        accessToken: tokenResponse["access_token"],
        refreshToken: tokenResponse["refresh_token"],
        expiresAt: now
    );
  }


}

class Token {
  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;

  Token({this.accessToken, this.refreshToken, this.expiresAt});
}
