import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kiding/screen/layout/complete_layout.dart';
import 'kikisday_random_dice_screen.dart';

class KikisdayTalmudCompleteScreen extends StatefulWidget {
  final int currentNumber;

  KikisdayTalmudCompleteScreen({Key? key, required this.currentNumber})
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
    log('currentNumber: ${widget.currentNumber}');
  }

  @override
  Widget build(BuildContext context) {
    return CompleteLayout(
      bgStr: 'assets/kikisday/kikisday_dice_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      completeStr: 'assets/kikisday/red_complete.png',
      timerColor: Color(0xFF868686),
    );
  }
}
