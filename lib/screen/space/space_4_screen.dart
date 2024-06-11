import 'package:flutter/material.dart';
import 'package:kiding/screen/layout/card_layout.dart';
import 'package:kiding/screen/space/space_red_complete_screen.dart';

class Space4Screen extends StatefulWidget {
  const Space4Screen({super.key});

  @override
  State<Space4Screen> createState() => _Space4ScreenState();
}

class _Space4ScreenState extends State<Space4Screen> {
  @override
  Widget build(BuildContext context) {
    return CardLayout(
        bgStr: 'assets/space/card_bg.png',
        backBtnStr: 'assets/space/back_icon_white.png',
        textStr: 'assets/space/4_text.png',
        cardStr: 'assets/space/red_card.png',
        completeScreen: SpaceRedCompleteScreen(
          currentNumber: 4,
        ),
        okBtnStr: 'assets/space/red_btn.png',
        timerColor: Color(0xFFE7E7E7));
  }
}
