import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';

class FriendsListService {
  final storage = FlutterSecureStorage();

  Future<List<Map<String, dynamic>>> fetchFriendsList() async {
    String? token = await storage.read(key: 'accessToken');

    var url = Uri.parse('${ApiConstants.baseUrl}/friends/list');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['isSuccess']) {
          // 서버로부터 받은 친구 목록 데이터 반환
          return List<Map<String, dynamic>>.from(data['result']);
        } else {
          print("서버 응답 오류: ${data['message']}");
          return [];
        }
      } else {
        print("HTTP 오류: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("네트워크 오류: $e");
      return [];
    }
  }
}
