import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kiding/screen/kikisday/talmud_story_4_screen.dart';
import '../layout/talmud_story_layout.dart';

class KikisdayTalmudStory3Screen extends StatefulWidget {
  final int userId;

  const KikisdayTalmudStory3Screen({super.key, required int currentNumber, required this.userId});

  @override
  State<KikisdayTalmudStory3Screen> createState() =>
      _KikisdayTalmudStory3ScreenState();
}

class _KikisdayTalmudStory3ScreenState
    extends State<KikisdayTalmudStory3Screen> {
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
        builder: (context) => KikisdayTalmudStory4Screen(
          currentNumber: 1,
          userId: widget.userId
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
        'assets/kikisday/talmud_story_3.png',
        width: 339.79,
        height: 476.3,
      ),
      timerColor: Color(0xFF868686),
    );
  }
}
