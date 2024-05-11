import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:smartlocker/common/failure.dart';
import 'package:smartlocker/models/Token.dart';
import 'package:uuid/uuid.dart';

class TokenService {
  Future<Either<Failure,TokenModel>> getToken(String productName,int productPrice) async {
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
        return right(TokenModel(token: jsonResponse['token']));
      } else {
        return left(ServerFailure(
            data: response.body,
            code: response.statusCode,
            message: 'Unknown Error'));
      }
    } catch (e) {
      return left(ServerFailure(
          data: e.toString(), code: 400, message: 'Unknown Error'));
    }
  }
}
