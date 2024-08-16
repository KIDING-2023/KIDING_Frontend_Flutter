import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kiding/screen/kikisday/kikisday_random_dice2_screen.dart';
import 'package:kiding/screen/layout/complete_layout.dart';
import '../layout/exit_layout.dart';
import 'kikisday_random_dice_screen.dart';

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
  int remainingTime = 3;

  // 다음 화면
  late var nextScreen;

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

  void _navigateToRandomDiceScreen() {
    switch (widget.currentNumber) {
      case 3:
        nextScreen =
            KikisdayRandomDiceScreen(currentNumber: widget.currentNumber);
        break;
      default:
        nextScreen =
            KikisdayRandomDice2Screen(currentNumber: widget.currentNumber);
        break;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
    log('currentNumber: ${widget.currentNumber}');
  }

  void _onBackButtonPressed() {
    _pauseTimer(); // 타이머 일시정지
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExitLayout(
          onKeepPressed: _resumeTimer,
          onExitPressed: () {},
          isFromDiceOrCamera: false,
          isFromCard: false,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompleteLayout(
      bgStr: 'assets/kikisday/kikisday_dice_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      completeStr: 'assets/kikisday/blue_complete.png',
      timerColor: Color(0xFF868686),
      onBackButtonPressed: _onBackButtonPressed,
    );
  }
}
