import 'dart:convert';

import 'package:http/http.dart' as http;

import './Message.dart';
import './exceptions.dart';

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
        expiresAt: now
    );
  }

  Future<Message> storeMessage(Message message) async {
    http.Response response = await http.post("${baseUrl}/api/messages", body: {
      "message": message.message,
      "email": message.email
    },
        headers: {
          "authorization": "Bearer ${token.accessToken}",
          "accept": "application/json"
        }
    );

    dynamic messageResponse = jsonDecode(response.body);

    if (response.statusCode == 401) {
      throw UnauthorizedException(messageResponse["message"]);
    }

    if(response.statusCode < 200 || response.statusCode > 299) {
      throw HttpException(response.statusCode, messageResponse["message"]);
    }

    message.url = messageResponse["decrypt_route"];
    message.password = messageResponse["password"];

    return message;
  }
}

class Token {
  final String accessToken;
  final DateTime expiresAt;

  Token({this.accessToken, this.expiresAt});
}
