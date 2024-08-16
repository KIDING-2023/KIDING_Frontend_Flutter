import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kiding/screen/kikisday/talmud_story_4_screen.dart';
import '../layout/exit_layout.dart';
import '../layout/talmud_story_layout.dart';

class KikisdayTalmudStory3Screen extends StatefulWidget {
  const KikisdayTalmudStory3Screen({super.key, required int currentNumber});

  @override
  State<KikisdayTalmudStory3Screen> createState() =>
      _KikisdayTalmudStory3ScreenState();
}

class _KikisdayTalmudStory3ScreenState
    extends State<KikisdayTalmudStory3Screen> {
  late Timer _timer;
  final int duration = 5; // 3초 후 화면 전환
  int remainingTime = 3;

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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => KikisdayTalmudStory4Screen(
          currentNumber: 1,
        ),
      ),
    );
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
    return TalmudStoryLayout(
      bgStr: 'assets/kikisday/kikisday_dice_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      storyWid: Image.asset(
        'assets/kikisday/talmud_story_3.png',
        width: 339.79,
        height: 476.3,
      ),
      timerColor: Color(0xFF868686),
      onBackButtonPressed: _onBackButtonPressed,
    );
  }
}
