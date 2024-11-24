import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';

class GameService {
  final _storage = FlutterSecureStorage();

  Future<String> sendGameCompleteRequest(int boardGameId, int chips) async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.boardgameEndpoint}/final');
    String? token = await _storage.read(key: 'accessToken');

    if (token == null) {
      return "토큰이 없습니다.";
    }

    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'boardGameId': boardGameId,
      'count': chips,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['isSuccess'] ? data['message'] : data['message'];
      } else {
        return '서버 오류: 상태 코드 ${response.statusCode}';
      }
    } catch (e) {
      return '네트워크 오류: $e';
    }
  }
}
