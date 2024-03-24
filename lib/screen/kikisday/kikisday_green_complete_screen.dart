import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import '../layout/complete_layout.dart';
import 'kikisday_random_dice_screen.dart';

class KikisdayGreenCompleteScreen extends StatefulWidget {
  final int currentNumber;

  KikisdayGreenCompleteScreen({Key? key, required this.currentNumber})
      : super(key: key);

  @override
  State<KikisdayGreenCompleteScreen> createState() =>
      _KikisdayGreenCompleteScreenState();
}

class _KikisdayGreenCompleteScreenState
    extends State<KikisdayGreenCompleteScreen> {
  late Timer _timer;
  final int duration = 3; // 3초 후 화면 전환

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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => KikisdayRandomDiceScreen(
          currentNumber: widget.currentNumber,
        ),
      ),
    );
    log(widget.currentNumber);
  }

  @override
  Widget build(BuildContext context) {
    return CompleteLayout(
      bgStr: 'assets/kikisday/kikisday_dice_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      completeStr: 'assets/kikisday/green_complete.png',
      timerColor: Color(0xFF868686),
    );
  }
}
