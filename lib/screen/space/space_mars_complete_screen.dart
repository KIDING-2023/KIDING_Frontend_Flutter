import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kiding/screen/space/space_random_dice_2_screen.dart';
import 'package:kiding/screen/space/space_random_dice_3_screen.dart';

import '../layout/complete_layout.dart';

class SpaceMarsCompleteScreen extends StatefulWidget {
  final int currentNumber;
  final bool canread;

  const SpaceMarsCompleteScreen({super.key, required this.currentNumber, required this.canread});

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
            SpaceRandomDice3Screen(currentNumber: widget.currentNumber, canread: widget.canread,);
        break;
      default:
        nextScreen =
            SpaceRandomDice2Screen(currentNumber: widget.currentNumber, canread: widget.canread,);
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
      bgStr: 'assets/space/mars_dice_bg.png',
      backBtnStr: 'assets/space/back_icon_white.png',
      completeStr: 'assets/space/mars_complete_text.png',
      timerColor: Color(0xFFE7E7E7),
    );
  }
}
