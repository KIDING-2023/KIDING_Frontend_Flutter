import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kiding/screen/kikisday/kikisday_random_dice2_screen.dart';
import 'package:kiding/screen/layout/complete_layout.dart';
import 'kikisday_random_dice_screen.dart';

import 'package:http/http.dart' as http;

class KikisdayBlueCompleteScreen extends StatefulWidget {
  final int currentNumber;

  KikisdayBlueCompleteScreen({Key? key, required this.currentNumber})
      : super(key: key);

  @override
  State<KikisdayBlueCompleteScreen> createState() =>
      _KikisdayBlueCompleteScreenState();
}

class _KikisdayBlueCompleteScreenState
    extends State<KikisdayBlueCompleteScreen> {
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
      case 3:
        nextScreen =
            KikisdayRandomDiceScreen(currentNumber: widget.currentNumber);
        _answerSuccess();
        break;
      default:
        nextScreen =
            KikisdayRandomDice2Screen(currentNumber: widget.currentNumber);
        _answerSuccess();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompleteLayout(
      bgStr: 'assets/kikisday/kikisday_dice_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      completeStr: 'assets/kikisday/blue_complete.png',
      timerColor: Color(0xFF868686),
    );
  }

  // 답변 완료 데베 전달
  Future<void> _answerSuccess() async {
    var url = Uri.parse('http://3.37.76.76:8081/boardgame');
    var response = await http.post(url,
        body: jsonEncode({}),
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
