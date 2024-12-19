import 'package:flutter/material.dart';
import 'package:kiding_frontend/screen/layout/tutorial_layout.dart';
import 'package:kiding_frontend/screen/space/space_random_dice_screen.dart';

class SpaceTutorial2Screen extends StatefulWidget {
  //final bool canread;

  const SpaceTutorial2Screen({super.key});

  @override
  State<SpaceTutorial2Screen> createState() => _SpaceTutorial2ScreenState();
}

class _SpaceTutorial2ScreenState extends State<SpaceTutorial2Screen> {
  @override
  Widget build(BuildContext context) {
    return TutorialLayout(
      bgStr: 'assets/space/space_tutorial_bg.png',
      backBtnStr: 'assets/space/back_icon_white.png',
      textWid: Image.asset(
        'assets/kikisday/kikisday_tutorial2_text.png',
        width: 339.79,
        height: 229.08,
      ),
      characterWid: Image.asset(
        'assets/space/space_tutorial2_ch.png',
        width: 360,
        height: 302.53,
      ),
      okBtnStr: 'assets/kikisday/kikisday_ok_btn.png',
      nextScreen: SpaceRandomDiceScreen(),
      timerColorStr: Color(0xFFE7E7E7),
    );
  }
}
