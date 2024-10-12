import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kiding/screen/layout/complete_layout.dart';
import '../layout/exit_layout.dart';
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
  int remainingTime = 3;

  // 초기 키딩칩 개수
  int chips = 0;

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
    chips += 3;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => KikisdayRandomDiceScreen(
          currentNumber: widget.currentNumber,
          chips: chips
        ),
      ),
    );
    log('currentNumber: ${widget.currentNumber}, chips: ${chips}');
  }

  void _onBackButtonPressed() {
    _timer?.cancel(); // 타이머 취소
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ExitLayout(
                onKeepPressed: _resumeTimer,
                onExitPressed: () {},
                isFromDiceOrCamera: false,
                isFromCard: false,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompleteLayout(
      bgStr: 'assets/kikisday/kikisday_dice_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      completeStr: 'assets/kikisday/talmud_complete.png',
      timerColor: Color(0xFF868686),
      onBackButtonPressed: _onBackButtonPressed,
    );
  }
}
