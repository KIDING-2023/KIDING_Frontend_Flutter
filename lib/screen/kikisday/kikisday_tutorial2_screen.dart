import 'package:flutter/material.dart';
import 'package:kiding/screen/kikisday/kikisday_dice_screen.dart';
import 'package:kiding/screen/layout/tutorial_layout.dart';

class KikisdayTutorial2Screen extends StatefulWidget {
  final int userId;

  const KikisdayTutorial2Screen({super.key, required this.userId});

  @override
  _KikisdayTutorial2ScreenState createState() =>
      _KikisdayTutorial2ScreenState();
}

class _KikisdayTutorial2ScreenState extends State<KikisdayTutorial2Screen> {
  @override
  Widget build(BuildContext context) {
    return TutorialLayout(
      bgStr: 'assets/kikisday/kikisday_tutorial1_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      textWid: Image.asset(
        'assets/kikisday/kikisday_tutorial2_text.png',
        width: 339.79,
        height: 229.08,
      ),
      characterWid: Image.asset(
        'assets/kikisday/kikisday_tutorial2_ch.png',
        width: 360,
        height: 302.53,
      ),
      okBtnStr: 'assets/kikisday/kikisday_ok_btn.png',
      timerColorStr: Color(0xFF868686),
      screenBuilder: (context) => KikisdayDiceScreen(userId: widget.userId),
    );
  }
}
