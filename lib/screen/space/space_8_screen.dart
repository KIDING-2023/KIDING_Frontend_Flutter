import 'package:flutter/material.dart';
import 'package:kiding/screen/space/space_mars_complete_screen.dart';

import '../layout/card_layout.dart';

class Space8Screen extends StatefulWidget {
  const Space8Screen({super.key});

  @override
  State<Space8Screen> createState() => _Space8ScreenState();
}

class _Space8ScreenState extends State<Space8Screen> {
  @override
  Widget build(BuildContext context) {
    return CardLayout(
        bgStr: 'assets/space/mars_card_bg.png',
        backBtnStr: 'assets/space/back_icon_white.png',
        textStr: 'assets/space/8_text.png',
        cardStr: 'assets/space/mars_card.png',
        completeScreen: SpaceMarsCompleteScreen(
          currentNumber: 8,
        ),
        okBtnStr: 'assets/space/mars_card_btn.png',
        timerColor: Color(0xFFE7E7E7));
  }
}
