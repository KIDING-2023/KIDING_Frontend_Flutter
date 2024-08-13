import 'package:flutter/material.dart';
import '../layout/card_layout.dart';
import 'kikisday_red_complete3_screen.dart';

class Kikisday19Screen extends StatefulWidget {
  const Kikisday19Screen({super.key});

  @override
  State<Kikisday19Screen> createState() => _Kikisday19ScreenState();
}

class _Kikisday19ScreenState extends State<Kikisday19Screen> {
  @override
  Widget build(BuildContext context) {
    return CardLayout(
      bgStr: 'assets/kikisday/kikisday_4_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      textStr: 'assets/kikisday/kikisday_19_text.png',
      cardStr: 'assets/kikisday/kikisday_red_card.png',
      completeScreen: KikisdayRedComplete3Screen(currentNumber: 19),
      okBtnStr: 'assets/kikisday/kikisday_red_btn.png',
      timerColor: Color(0xFF868686),
      currentNumber: 19,
    );
  }
}
