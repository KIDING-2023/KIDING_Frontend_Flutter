import 'package:flutter/material.dart';
import 'package:kiding/screen/layout/tutorial_layout.dart';

class SpaceTutorial1Screen extends StatefulWidget {
  const SpaceTutorial1Screen({super.key});

  @override
  State<SpaceTutorial1Screen> createState() => _SpaceTutorial1ScreenState();
}

class _SpaceTutorial1ScreenState extends State<SpaceTutorial1Screen> {
  @override
  Widget build(BuildContext context) {
    return TutorialLayout(
      bgStr: 'assets/space/space_tutorial_bg.png',
      backBtnStr: 'assets/space/back_icon_white.png',
      textWid: Image.asset('assets/kikisday/kikisday_tutorial1_text.png',
          width: 339.79, height: 296.58),
      characterWid: Image.asset('assets/space/space_tutorial1_ch.png',
          width: 360, height: 348.39),
      okBtnStr: 'assets/kikisday/kikisday_ok_btn.png',
      nextScreenStr: '/space_tutorial2',
      timerColorStr: Color(0xFFE7E7E7),
    );
  }
}
