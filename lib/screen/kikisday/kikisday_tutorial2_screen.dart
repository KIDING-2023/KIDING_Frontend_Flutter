import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiding_frontend/screen/kikisday/kikisday_dice_screen.dart';
import 'package:kiding_frontend/screen/layout/tutorial_layout.dart';

class KikisdayTutorial2Screen extends StatefulWidget {
  const KikisdayTutorial2Screen({super.key});

  @override
  KikisdayTutorial2ScreenState createState() => KikisdayTutorial2ScreenState();
}

class KikisdayTutorial2ScreenState extends State<KikisdayTutorial2Screen> {
  @override
  Widget build(BuildContext context) {
    return TutorialLayout(
      bgStr: 'assets/kikisday/kikisday_tutorial1_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      textWid: Image.asset(
        'assets/kikisday/kikisday_tutorial2_text.png',
        width: 339.79.w,
        height: 229.08.h,
      ),
      characterWid: Image.asset(
        'assets/kikisday/kikisday_tutorial2_ch.png',
        width: 360.w,
        height: 302.53.h,
      ),
      okBtnStr: 'assets/kikisday/kikisday_ok_btn.png',
      nextScreen: KikisdayDiceScreen(),
      timerColorStr: Color(0xFF868686),
    );
  }
}
