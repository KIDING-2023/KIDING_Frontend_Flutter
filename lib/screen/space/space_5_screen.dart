import 'package:flutter/material.dart';
import 'package:kiding/screen/space/space_red_complete_screen.dart';
import 'package:kiding/screen/space/space_venus_complete_screen.dart';

import '../layout/card_layout.dart';

class Space5Screen extends StatefulWidget {
  const Space5Screen({super.key});

  @override
  State<Space5Screen> createState() => _Space5ScreenState();
}

class _Space5ScreenState extends State<Space5Screen> {
  @override
  Widget build(BuildContext context) {
    return CardLayout(
        bgStr: 'assets/space/venus_card_bg.png',
        backBtnStr: 'assets/space/back_icon_white.png',
        textStr: 'assets/space/5_text.png',
        cardStr: 'assets/space/venus_card.png',
        completeScreen: SpaceVenusCompleteScreen(
          currentNumber: 5,
        ),
        okBtnStr: 'assets/space/venus_card_btn.png',
        timerColor: Color(0xFFE7E7E7));
  }
}
