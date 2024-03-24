import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import '../layout/complete_layout.dart';
import 'kikisday_random_dice4_screen.dart';

class KikisdayRedComplete3Screen extends StatefulWidget {
  final int currentNumber;

  KikisdayRedComplete3Screen({Key? key, required this.currentNumber}) : super(key: key);

  @override
  State<KikisdayRedComplete3Screen> createState() => _KikisdayRedComplete3ScreenState();
}

class _KikisdayRedComplete3ScreenState extends State<KikisdayRedComplete3Screen> {
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
        builder: (context) => KikisdayRandomDice4Screen(
          currentNumber: widget.currentNumber,
        ),
      ),
    );
    log('currentNumber: ${widget.currentNumber}');
  }

  @override
  Widget build(BuildContext context) {
    return CompleteLayout(
        bgStr: 'assets/kikisday/kikisday_4_dice_bg.png',
        backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
        completeStr: 'assets/kikisday/red_complete.png');
  }
}
