import 'package:flutter/material.dart';
import 'package:kiding/screen/space/space_red_complete_screen.dart';

import '../layout/card_layout.dart';

class Space6Screen extends StatefulWidget {
  const Space6Screen({super.key});

  @override
  State<Space6Screen> createState() => _Space6ScreenState();
}

class _Space6ScreenState extends State<Space6Screen> {
  @override
  Widget build(BuildContext context) {
    return CardLayout(
        bgStr: 'assets/space/card_bg.png',
        backBtnStr: 'assets/space/back_icon_white.png',
        textStr: 'assets/space/6_text.png',
        cardStr: 'assets/space/red_card.png',
        completeScreen: SpaceRedCompleteScreen(
          currentNumber: 6,
        ),
        okBtnStr: 'assets/space/red_btn.png',
        timerColor: Color(0xFFE7E7E7));
  }
}
