import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kiding/screen/kikisday/talmud_question_1_screen.dart';
import '../layout/talmud_story_layout.dart';

class KikisdayTalmudStory4Screen extends StatefulWidget {
  const KikisdayTalmudStory4Screen({super.key, required int currentNumber});

  @override
  State<KikisdayTalmudStory4Screen> createState() =>
      _KikisdayTalmudStory4ScreenState();
}

class _KikisdayTalmudStory4ScreenState
    extends State<KikisdayTalmudStory4Screen> {
  late Timer _timer;
  final int duration = 5; // 3초 후 화면 전환

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
        builder: (context) => KikisdayTalmudQuestion1Screen(
          currentNumber: 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TalmudStoryLayout(
      bgStr: 'assets/kikisday/kikisday_dice_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      storyWid: Image.asset(
        'assets/kikisday/talmud_story_4.png',
        width: 339.79,
        height: 527.05,
      ),
      timerColor: Color(0xFF868686),
    );
  }
}
