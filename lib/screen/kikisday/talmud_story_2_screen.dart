import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kiding/screen/kikisday/talmud_story_3_screen.dart';
import '../layout/talmud_story_layout.dart';

class KikisdayTalmudStory2Screen extends StatefulWidget {
  const KikisdayTalmudStory2Screen({super.key, required int currentNumber});

  @override
  State<KikisdayTalmudStory2Screen> createState() =>
      _KikisdayTalmudStory2ScreenState();
}

class _KikisdayTalmudStory2ScreenState
    extends State<KikisdayTalmudStory2Screen> {
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
        builder: (context) => KikisdayTalmudStory3Screen(
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
          'assets/kikisday/talmud_story_2.png',
          width: 339.79,
          height: 527.05,
        ));
  }
}
