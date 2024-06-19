import 'package:flutter/material.dart';
import 'package:kiding/screen/space/space_mars_complete_screen.dart';

import '../layout/card_layout.dart';

class Space7Screen extends StatefulWidget {
  const Space7Screen({super.key});

  @override
  State<Space7Screen> createState() => _Space7ScreenState();
}

class _Space7ScreenState extends State<Space7Screen> {
  @override
  Widget build(BuildContext context) {
    return CardLayout(
        bgStr: 'assets/space/mars_card_bg.png',
        backBtnStr: 'assets/space/back_icon_white.png',
        textStr: 'assets/space/7_text.png',
        cardStr: 'assets/space/mars_card.png',
        completeScreen: SpaceMarsCompleteScreen(
          currentNumber: 7,
        ),
        okBtnStr: 'assets/space/mars_card_btn.png',
        timerColor: Color(0xFFE7E7E7));
  }
}
