import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiding_frontend/screen/kikisday/talmud_story_3_screen.dart';
import 'package:kiding_frontend/screen/layout/exit_layout.dart';
import 'package:kiding_frontend/screen/layout/talmud_story_layout.dart';

class KikisdayTalmudStory2Screen extends StatefulWidget {
  const KikisdayTalmudStory2Screen({super.key});

  @override
  State<KikisdayTalmudStory2Screen> createState() =>
      _KikisdayTalmudStory2ScreenState();
}

class _KikisdayTalmudStory2ScreenState
    extends State<KikisdayTalmudStory2Screen> {
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
        builder: (context) => KikisdayTalmudStory3Screen(),
      ),
    );
  }

  void _onBackButtonPressed() {
    _timer.cancel(); // 타이머 취소
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
        'assets/kikisday/talmud_story_2.png',
        width: 339.w,
        height: 527.05.h,
      ),
      timerColor: Color(0xFF868686),
      onBackButtonPressed: _onBackButtonPressed,
    );
  }
}
