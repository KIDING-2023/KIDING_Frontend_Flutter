import 'package:flutter/material.dart';
import 'package:kiding/screen/space/space_earth_complete_screen.dart';

import '../layout/space_card_layout.dart';

class Space1Screen extends StatefulWidget {
  const Space1Screen({super.key});

  @override
  State<Space1Screen> createState() => _Space1ScreenState();
}

class _Space1ScreenState extends State<Space1Screen> {
  @override
  Widget build(BuildContext context) {
    return SpaceCardLayout(
      bgStr: 'assets/space/earth_card_bg.png',
      backBtnStr: 'assets/space/back_icon_white.png',
      textStr: 'assets/space/1_text.png',
      cardStr: 'assets/space/earth_card.png',
      completeScreen: SpaceEarthCompleteScreen(currentNumber: 1),
      okBtnStr: 'assets/space/earth_card_btn.png',
      timerColor: Color(0xFFE7E7E7),
      currentNumber: 1,
    );
  }
}
