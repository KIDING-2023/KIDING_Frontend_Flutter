import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kiding/screen/space/space_random_dice_2_screen.dart';
import 'package:kiding/screen/space/space_random_dice_screen.dart';

import '../layout/complete_layout.dart';

class SpaceVenusCompleteScreen extends StatefulWidget {
  final int currentNumber;
  //final bool canread;

  const SpaceVenusCompleteScreen({super.key, required this.currentNumber});

  @override
  State<SpaceVenusCompleteScreen> createState() => _SpaceVenusCompleteScreenState();
}

class _SpaceVenusCompleteScreenState extends State<SpaceVenusCompleteScreen> {
  late Timer _timer;
  final int duration = 5; // 3초 후 화면 전환
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
      case 6:
        nextScreen =
            SpaceRandomDice2Screen(currentNumber: widget.currentNumber);
        break;
      default:
        nextScreen =
            SpaceRandomDiceScreen(currentNumber: widget.currentNumber);
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
      bgStr: 'assets/space/venus_dice_bg.png',
      backBtnStr: 'assets/space/back_icon_white.png',
      completeStr: 'assets/space/venus_complete_text.png',
      timerColor: Color(0xFFE7E7E7),
    );
  }
}
