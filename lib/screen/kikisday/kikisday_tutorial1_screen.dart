import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiding_frontend/screen/kikisday/kikisday_tutorial2_screen.dart';
import 'package:kiding_frontend/screen/layout/tutorial_layout.dart';

class KikisdayTutorial1Screen extends StatefulWidget {
  const KikisdayTutorial1Screen({super.key});

  @override
  KikisdayTutorial1ScreenState createState() => KikisdayTutorial1ScreenState();
}

class KikisdayTutorial1ScreenState extends State<KikisdayTutorial1Screen> {
  @override
  Widget build(BuildContext context) {
    return TutorialLayout(
      bgStr: 'assets/kikisday/kikisday_tutorial1_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      textWid: Image.asset('assets/kikisday/kikisday_tutorial1_text.png',
          width: 339.79.w, height: 296.58.h),
      characterWid: Image.asset('assets/kikisday/kikisday_tutorial1_ch.png',
          width: 360.w, height: 348.39.h),
      okBtnStr: 'assets/kikisday/kikisday_ok_btn.png',
      nextScreen: KikisdayTutorial2Screen(),
      timerColorStr: Color(0xFF868686),
    );
  }
}
