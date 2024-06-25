import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kiding/screen/layout/complete_layout.dart';
import 'kikisday_random_dice_screen.dart';

import 'package:http/http.dart' as http;

class KikisdayTalmudCompleteScreen extends StatefulWidget {
  final int currentNumber;
  final int userId;

  KikisdayTalmudCompleteScreen({Key? key, required this.currentNumber, required this.userId})
      : super(key: key);

  @override
  State<KikisdayTalmudCompleteScreen> createState() =>
      _KikisdayTalmudCompleteScreenState();
}

class _KikisdayTalmudCompleteScreenState
    extends State<KikisdayTalmudCompleteScreen> {
  late Timer _timer;
  final int duration = 3; // 3초 후 화면 전환

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: duration), _answerSuccess);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompleteLayout(
      bgStr: 'assets/kikisday/kikisday_dice_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      completeStr: 'assets/kikisday/talmud_complete.png',
      timerColor: Color(0xFF868686),
    );
  }

  // 답변 완료 데베 전달
  Future<void> _answerSuccess() async {
    var url = Uri.parse('http://3.37.76.76:8081/boardgame');
    var response = await http.post(url,
        body: jsonEncode(
            {'name': '키키의 하루', 'userId': widget.userId}),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => KikisdayRandomDiceScreen(
            currentNumber: widget.currentNumber,
            userId: widget.userId
          ),
        ),
      );
      log('currentNumber: ${widget.currentNumber}');
    } else {
      // 오류 메시지 로그 출력
      log('답변 완료에 실패하였습니다.' as String);
    }
  }
}
