import 'package:flutter/material.dart';
import 'package:kiding/screen/space/space_earth_complete_screen.dart';

import '../layout/space_card_layout.dart';

class Space2Screen extends StatefulWidget {
  const Space2Screen({super.key});

  @override
  State<Space2Screen> createState() => _Space2ScreenState();
}

class _Space2ScreenState extends State<Space2Screen> {
  @override
  Widget build(BuildContext context) {
    return SpaceCardLayout(
      bgStr: 'assets/space/earth_card_bg.png',
      backBtnStr: 'assets/space/back_icon_white.png',
      textStr: 'assets/space/2_text.png',
      cardStr: 'assets/space/earth_card.png',
      completeScreen: SpaceEarthCompleteScreen(currentNumber: 2),
      okBtnStr: 'assets/space/earth_card_btn.png',
      timerColor: Color(0xFFE7E7E7),
      currentNumber: 2,
    );
  }
}
