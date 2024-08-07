import 'package:flutter/material.dart';
import 'package:kiding/screen/space/space_earth_complete_screen.dart';

import '../layout/space_card_layout.dart';

class Space3Screen extends StatefulWidget {
  const Space3Screen({super.key});

  @override
  State<Space3Screen> createState() => _Space3ScreenState();
}

class _Space3ScreenState extends State<Space3Screen> {
  @override
  Widget build(BuildContext context) {
    return SpaceCardLayout(
      bgStr: 'assets/space/earth_card_bg.png',
      backBtnStr: 'assets/space/back_icon_white.png',
      textStr: 'assets/space/3_text.png',
      cardStr: 'assets/space/earth_card.png',
      completeScreen: SpaceEarthCompleteScreen(currentNumber: 3),
      okBtnStr: 'assets/space/earth_card_btn.png',
      timerColor: Color(0xFFE7E7E7),
      currentNumber: 3,
    );
  }
}
