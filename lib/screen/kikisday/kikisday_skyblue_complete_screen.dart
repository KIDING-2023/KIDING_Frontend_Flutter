import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kiding/screen/kikisday/kikisday_random_dice2_screen.dart';
import '../layout/complete_layout.dart';
import 'kikisday_random_dice3_screen.dart';

class KikisdaySkyblueCompleteScreen extends StatefulWidget {
  final int currentNumber;

  KikisdaySkyblueCompleteScreen({Key? key, required this.currentNumber})
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
            KikisdayRandomDice3Screen(currentNumber: widget.currentNumber);
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

  @override
  Widget build(BuildContext context) {
    return CompleteLayout(
      bgStr: 'assets/kikisday/kikisday_2_dice_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      completeStr: 'assets/kikisday/skyblue_complete.png',
      timerColor: Color(0xFF868686),
    );
  }
}
