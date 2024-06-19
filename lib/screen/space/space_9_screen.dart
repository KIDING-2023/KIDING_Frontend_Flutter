import 'package:flutter/material.dart';
import 'package:kiding/screen/space/space_mars_complete_screen.dart';

import '../layout/card_layout.dart';

class Space9Screen extends StatefulWidget {
  const Space9Screen({super.key});

  @override
  State<Space9Screen> createState() => _Space9ScreenState();
}

class _Space9ScreenState extends State<Space9Screen> {
  @override
  Widget build(BuildContext context) {
    return CardLayout(
        bgStr: 'assets/space/mars_card_bg.png',
        backBtnStr: 'assets/space/back_icon_white.png',
        textStr: 'assets/space/9_text.png',
        cardStr: 'assets/space/mars_card.png',
        completeScreen: SpaceMarsCompleteScreen(
          currentNumber: 9,
        ),
        okBtnStr: 'assets/space/mars_card_btn.png',
        timerColor: Color(0xFFE7E7E7));
  }
}
