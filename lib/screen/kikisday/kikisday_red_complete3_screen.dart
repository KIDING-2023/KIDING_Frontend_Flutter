import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kiding/screen/kikisday/kikisday_random_dice4_screen.dart';
import '../../constants/api_constants.dart';
import '../layout/complete_layout.dart';
import '../layout/exit_layout.dart';

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class KikisdayRedComplete3Screen extends StatefulWidget {
  final int currentNumber;
  final int chips;

  KikisdayRedComplete3Screen({Key? key, required this.currentNumber, required this.chips})
      : super(key: key);

  @override
  State<KikisdayRedComplete3Screen> createState() =>
      _KikisdayRedComplete3ScreenState();
}

class _KikisdayRedComplete3ScreenState
    extends State<KikisdayRedComplete3Screen> {
  late Timer _timer;
  final int duration = 3; // 3초 후 화면 전환
  int remainingTime = 3;

  @override
  void initState() {
    super.initState();
    _startTimer(remainingTime);
  }

  void _startTimer(int duration) {
    _timer = Timer(Duration(seconds: duration), _navigateToRandomDiceScreen);
  }

  void _pauseTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer?.cancel();
    }
  }

  void _resumeTimer() {
    _startTimer(remainingTime);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  final storage = FlutterSecureStorage();

  // 서버에 키딩칩 개수를 전송하는 함수
  Future<void> _sendChipsToServer() async {
    final url = Uri.parse('${ApiConstants.baseUrl}/boardgame'); // 서버 URL
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
      'count': 1,   // 전송할 키딩칩 개수
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['isSuccess']) {
          print('서버 응답: ${data['message']}');
        } else {
          print('전송 실패: ${data['message']}');
        }
      } else {
        print('서버 오류: 상태 코드 ${response.statusCode}');
      }
    } catch (e) {
      print('네트워크 오류: $e');
    }
  }

  void _navigateToRandomDiceScreen() {
    _sendChipsToServer();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => KikisdayRandomDice4Screen(currentNumber: widget.currentNumber, chips: widget.chips + 1)
      ),
    );
    log('currentNumber: ${widget.currentNumber}');
  }

  void _onBackButtonPressed() {
    _timer?.cancel(); // 타이머 취소
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ExitLayout(
                onKeepPressed: _resumeTimer,
                onExitPressed: () {},
                isFromDiceOrCamera: false,
                isFromCard: false,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompleteLayout(
      bgStr: 'assets/kikisday/kikisday_4_dice_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      completeStr: 'assets/kikisday/red_complete.png',
      timerColor: Color(0xFF868686),
      onBackButtonPressed: _onBackButtonPressed,
    );
  }
}
