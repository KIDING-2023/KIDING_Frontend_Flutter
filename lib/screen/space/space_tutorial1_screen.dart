import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiding_frontend/screen/layout/tutorial_layout.dart';
import 'package:kiding_frontend/screen/space/space_tutorial2_screen.dart';

class SpaceTutorial1Screen extends StatefulWidget {
  //final bool canread;

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
          width: 339.79.w, height: 296.58.h),
      characterWid: Image.asset('assets/space/space_tutorial1_ch.png',
          width: 360.w, height: 348.39.h),
      okBtnStr: 'assets/kikisday/kikisday_ok_btn.png',
      nextScreen: SpaceTutorial2Screen(),
      timerColorStr: Color(0xFFE7E7E7),
    );
  }
}
