import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import '../layout/complete_layout.dart';
import 'kikisday_random_dice2_screen.dart';

class KikisdayRedCompleteScreen extends StatefulWidget {
  final int currentNumber;

  KikisdayRedCompleteScreen({Key? key, required this.currentNumber}) : super(key: key);

  @override
  State<KikisdayRedCompleteScreen> createState() => _KikisdayRedCompleteScreenState();
}

class _KikisdayRedCompleteScreenState extends State<KikisdayRedCompleteScreen> {
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
        builder: (context) => KikisdayRandomDice2Screen(
          currentNumber: widget.currentNumber,
        ),
      ),
    );
    log('currentNumber: ${widget.currentNumber}');
  }

  @override
  Widget build(BuildContext context) {
    return CompleteLayout(
        bgStr: 'assets/kikisday/kikisday_2_dice_bg.png',
        backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
        completeStr: 'assets/kikisday/red_complete.png');
  }
}
