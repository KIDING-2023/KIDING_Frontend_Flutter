import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kiding/screen/kikisday/kikisday_random_dice2_screen.dart';
import '../layout/complete_layout.dart';
import 'kikisday_random_dice3_screen.dart';

import 'package:http/http.dart' as http;

class KikisdaySkyblueCompleteScreen extends StatefulWidget {
  final int currentNumber;
  final int userId;

  KikisdaySkyblueCompleteScreen({Key? key, required this.currentNumber, required this.userId})
      : super(key: key);

  @override
  State<KikisdaySkyblueCompleteScreen> createState() =>
      _KikisdaySkyblueCompleteScreenState();
}

class _KikisdaySkyblueCompleteScreenState
    extends State<KikisdaySkyblueCompleteScreen> {
  late Timer _timer;
  final int duration = 3; // 3초 후 화면 전환

  // 다음 화면
  late var nextScreen;

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: duration), _navigateToRandomDiceScreen);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _navigateToRandomDiceScreen() {
    switch (widget.currentNumber) {
      case 10:
        nextScreen =
            KikisdayRandomDice3Screen(currentNumber: widget.currentNumber, userId: widget.userId);
        _answerSuccess();
        break;
      default:
        nextScreen =
            KikisdayRandomDice2Screen(currentNumber: widget.currentNumber, userId: widget.userId,);
        _answerSuccess();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompleteLayout(
      bgStr: 'assets/kikisday/kikisday_2_dice_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      completeStr: 'assets/kikisday/skyblue_complete.png',
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
      // 성공적인 처리, 주사위 화면으로 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => nextScreen),
      );
      log('currentNumber: ${widget.currentNumber}');
    } else {
      // 오류 메시지 로그 출력
      log('답변 완료에 실패하였습니다.');
    }
  }
}
