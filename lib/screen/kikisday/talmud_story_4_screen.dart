import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kiding/screen/kikisday/talmud_question_1_screen.dart';
import '../layout/exit_layout.dart';
import '../layout/talmud_story_layout.dart';

class KikisdayTalmudStory4Screen extends StatefulWidget {
  const KikisdayTalmudStory4Screen({super.key});

  @override
  State<KikisdayTalmudStory4Screen> createState() =>
      _KikisdayTalmudStory4ScreenState();
}

class _KikisdayTalmudStory4ScreenState
    extends State<KikisdayTalmudStory4Screen> {
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
        builder: (context) => KikisdayTalmudQuestion1Screen(),
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
      bgStr: 'assets/kikisday/kikisday_1_dice_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      storyWid: Image.asset(
        'assets/kikisday/talmud_story_4.png',
        width: 339.79,
        height: 527.05,
      ),
      timerColor: Color(0xFF868686),
      onBackButtonPressed: _onBackButtonPressed,
    );
  }
}
