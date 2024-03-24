import 'package:flutter/material.dart';
import '../layout/card_layout.dart';
import 'kikisday_orange_complete2_screen.dart';

class Kikisday14Screen extends StatefulWidget {
  const Kikisday14Screen({super.key});

  @override
  State<Kikisday14Screen> createState() => _Kikisday14ScreenState();
}

class _Kikisday14ScreenState extends State<Kikisday14Screen> {
  @override
  Widget build(BuildContext context) {
    return CardLayout(
      bgStr: 'assets/kikisday/kikisday_3_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      textStr: 'assets/kikisday/kikisday_14_text.png',
      cardStr: 'assets/kikisday/kikisday_orange_card.png',
      completeScreen: KikisdayOrangeComplete2Screen(currentNumber: 14),
      okBtnStr: 'assets/kikisday/kikisday_orange_btn.png',
      timerColor: Color(0xFF868686),
    );
  }
}
