import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kiding/screen/space/space_random_dice_2_screen.dart';
import 'package:kiding/screen/space/space_random_dice_3_screen.dart';

import '../layout/complete_layout.dart';

import 'package:http/http.dart' as http;

class SpaceMarsCompleteScreen extends StatefulWidget {
  final int currentNumber;
  final int userId;

  const SpaceMarsCompleteScreen({super.key, required this.currentNumber, required this.userId});

  @override
  State<SpaceMarsCompleteScreen> createState() => _SpaceMarsCompleteScreenState();
}

class _SpaceMarsCompleteScreenState extends State<SpaceMarsCompleteScreen> {
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
      case 7:
        nextScreen =
            SpaceRandomDice3Screen(currentNumber: widget.currentNumber, userId: widget.userId);
        _answerSuccess();
        break;
      default:
        nextScreen =
            SpaceRandomDice2Screen(currentNumber: widget.currentNumber, userId: widget.userId,);
        _answerSuccess();
        break;
    }
    log('currentNumber: ${widget.currentNumber}');
  }

  @override
  Widget build(BuildContext context) {
    return CompleteLayout(
      bgStr: 'assets/space/mars_dice_bg.png',
      backBtnStr: 'assets/space/back_icon_white.png',
      completeStr: 'assets/space/mars_complete_text.png',
      timerColor: Color(0xFFE7E7E7),
    );
  }

  // 답변 완료 데베 전달
  Future<void> _answerSuccess() async {
    var url = Uri.parse('http://3.37.76.76:8081/boardgame');
    var response = await http.post(url,
        body: jsonEncode(
            {'name': '키키의 우주여행', 'userId': widget.userId}),
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
