import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:kiding/constants/api_constants.dart';
import 'package:kiding/screen/home/home_screen.dart';
import 'package:kiding/screen/kikisday/set_player_number_screen.dart';
import 'package:provider/provider.dart';

import '../../model/timer_model.dart';
import 'kikisday_tutorial1_screen.dart';

class FinishScreen extends StatefulWidget {
  final int chips;

  const FinishScreen({super.key, required this.chips});

  @override
  State<FinishScreen> createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
// Flutter Secure Storage 인스턴스 생성
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _sendGameCompleteRequest(); // 화면이 로드될 때 서버 요청
  }

  // 게임 완료 요청 함수
  Future<void> _sendGameCompleteRequest() async {
    final url = Uri.parse('${ApiConstants.baseUrl}/boardgame/final'); // 서버 URL
    String? token = await storage.read(key: 'accessToken');

    if (token == null) {
      print("토큰이 없습니다.");
      return;
    }

    final headers = {
      'Authorization': 'Bearer $token', // 토큰을 Authorization 헤더에 포함
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'boardGameId': 1, // 고정된 보드게임 ID
      'count': 0,   // 전송할 키딩칩 개수
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['isSuccess']) {
          print('게임 완료: ${data['message']}');
        } else {
          print('게임 완료 실패: ${data['message']}');
        }
      } else {
        print('서버 오류: 상태 코드 ${response.statusCode}');
      }
    } catch (e) {
      print('네트워크 오류: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          // 배경 이미지
          Positioned.fill(
            child: Image.asset(
              'assets/kikisday/finish_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // 키딩칩 획득 이미지
          Positioned(
            top: screenHeight * 0.1639,
            left: 0,
            right: 0,
            child: Image.asset('assets/kikisday/finish_character.png',
                width: screenWidth * 0.9359, height: screenHeight * 0.5089),
          ),
          // 총 키딩칩 개수 배경
          Positioned(
              top: screenHeight * 0.6819,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/kikisday/chips_result_bg.png',
                width: screenWidth * 0.4726,
                height: screenHeight * 0.0846,
              )),
          // 총 키딩칩 개수
          Positioned(
              top: screenHeight * 0.714,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  widget.chips.toString() + '개',
                  style: TextStyle(
                      fontSize: screenHeight * 0.0375,
                      fontFamily: 'Nanum',
                      color: Color(0xffff815b)),
                ),
              )),
          // 다시 플레이 & 홈으로 버튼
          Positioned(
              top: screenHeight * 0.8725,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 다시 플레이
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SetPlayerNumberScreen()));
                      },
                      icon: Image.asset(
                        'assets/kikisday/replay_btn.png',
                        width: screenWidth * 0.4013,
                        height: screenHeight * 0.0521,
                      )),
                  // 홈으로
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreen()));
                      },
                      icon: Image.asset(
                        'assets/kikisday/to_home_btn.png',
                        width: screenWidth * 0.4013,
                        height: screenHeight * 0.0521,
                      )),
                ],
              ))
        ],
      ),
    );
  }
}
