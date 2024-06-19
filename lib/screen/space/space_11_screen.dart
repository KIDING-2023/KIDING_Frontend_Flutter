import 'package:flutter/material.dart';
import 'package:kiding/screen/space/space_mars_complete_screen.dart';
import 'package:kiding/screen/space/space_saturn_complete_screen.dart';

import '../layout/card_layout.dart';

class Space11Screen extends StatefulWidget {
  const Space11Screen({super.key});

  @override
  State<Space11Screen> createState() => _Space11ScreenState();
}

class _Space11ScreenState extends State<Space11Screen> {
  @override
  Widget build(BuildContext context) {
    return CardLayout(
        bgStr: 'assets/space/saturn_card_bg.png',
        backBtnStr: 'assets/space/back_icon_white.png',
        textStr: 'assets/space/11_text.png',
        cardStr: 'assets/space/saturn_card.png',
        completeScreen: SpaceSaturnCompleteScreen(
          currentNumber: 11,
        ),
        okBtnStr: 'assets/space/saturn_card_btn.png',
        timerColor: Color(0xFFE7E7E7));
  }
}
