import 'package:flutter/material.dart';
import 'package:kiding_frontend/screen/kikisday/kikisday_tutorial2_screen.dart';
import 'package:kiding_frontend/screen/layout/tutorial_layout.dart';

class KikisdayTutorial1Screen extends StatefulWidget {
  const KikisdayTutorial1Screen({super.key});

  @override
  _KikisdayTutorial1ScreenState createState() =>
      _KikisdayTutorial1ScreenState();
}

class _KikisdayTutorial1ScreenState extends State<KikisdayTutorial1Screen> {
  @override
  Widget build(BuildContext context) {
    return TutorialLayout(
      bgStr: 'assets/kikisday/kikisday_tutorial1_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      textWid: Image.asset('assets/kikisday/kikisday_tutorial1_text.png',
          width: 339.79, height: 296.58),
      characterWid: Image.asset('assets/kikisday/kikisday_tutorial1_ch.png',
          width: 360, height: 348.39),
      okBtnStr: 'assets/kikisday/kikisday_ok_btn.png',
      nextScreen: KikisdayTutorial2Screen(),
      timerColorStr: Color(0xFF868686),
    );
  }
}
