import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:smartlocker/models/Token.dart';
import 'package:uuid/uuid.dart';

class TokenService {
  Future<dynamic> getToken(String productName,int productPrice) async {
    var uuid = const Uuid();
    var apiUrl = dotenv.env['BASE_URL'] ?? '';
    // Payload
    var payload = {
      "id": uuid.v1(),
      "productName": productName,
      "price": productPrice,
      "quantity": 1
    };
    var payloadJson = jsonEncode(payload);
    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: payloadJson,
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return TokenModel(token: jsonResponse['token']);
      } else {
        return 'Error: ${response.statusCode} - ${response.body}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
