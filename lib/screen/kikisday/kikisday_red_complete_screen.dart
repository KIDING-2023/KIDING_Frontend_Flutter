import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import '../layout/complete_layout.dart';
import 'kikisday_random_dice2_screen.dart';

import 'package:http/http.dart' as http;

class KikisdayRedCompleteScreen extends StatefulWidget {
  final int currentNumber;
  final int userId;

  KikisdayRedCompleteScreen(
      {Key? key, required this.currentNumber, required this.userId})
      : super(key: key);

  @override
  State<KikisdayRedCompleteScreen> createState() =>
      _KikisdayRedCompleteScreenState();
}

class _KikisdayRedCompleteScreenState extends State<KikisdayRedCompleteScreen> {
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
      bgStr: 'assets/kikisday/kikisday_2_dice_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      completeStr: 'assets/kikisday/red_complete.png',
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
          builder: (context) => KikisdayRandomDice2Screen(
            currentNumber: widget.currentNumber,
            userId: widget.userId,
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
