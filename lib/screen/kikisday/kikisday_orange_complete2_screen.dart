import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import '../layout/complete_layout.dart';
import 'kikisday_random_dice3_screen.dart';

class KikisdayOrangeComplete2Screen extends StatefulWidget {
  final int currentNumber;

  KikisdayOrangeComplete2Screen({Key? key, required this.currentNumber})
      : super(key: key);

  @override
  State<KikisdayOrangeComplete2Screen> createState() =>
      _KikisdayOrangeComplete2ScreenState();
}

class _KikisdayOrangeComplete2ScreenState
    extends State<KikisdayOrangeComplete2Screen> {
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
        builder: (context) => KikisdayRandomDice3Screen(
          currentNumber: widget.currentNumber,
        ),
      ),
    );
    log('currentNumber: ${widget.currentNumber}');
  }

  @override
  Widget build(BuildContext context) {
    return CompleteLayout(
      bgStr: 'assets/kikisday/kikisday_3_dice_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      completeStr: 'assets/kikisday/orange_complete.png',
      timerColor: Color(0xFF868686),
    );
  }
}
