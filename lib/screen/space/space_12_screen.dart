import 'package:flutter/material.dart';
import 'package:kiding/screen/space/space_mars_complete_screen.dart';
import 'package:kiding/screen/space/space_saturn_complete_screen.dart';

import '../layout/card_layout.dart';

class Space12Screen extends StatefulWidget {
  const Space12Screen({super.key});

  @override
  State<Space12Screen> createState() => _Space12ScreenState();
}

class _Space12ScreenState extends State<Space12Screen> {
  @override
  Widget build(BuildContext context) {
    return CardLayout(
        bgStr: 'assets/space/saturn_card_bg.png',
        backBtnStr: 'assets/space/back_icon_white.png',
        textStr: 'assets/space/12_text.png',
        cardStr: 'assets/space/saturn_card.png',
        completeScreen: SpaceSaturnCompleteScreen(
          currentNumber: 12,
        ),
        okBtnStr: 'assets/space/saturn_card_btn.png',
        timerColor: Color(0xFFE7E7E7));
  }
}
