import 'package:flutter/material.dart';
import '../layout/card_layout.dart';
import 'kikisday_red_complete2_screen.dart';

class Kikisday15Screen extends StatefulWidget {
  const Kikisday15Screen({super.key});

  @override
  State<Kikisday15Screen> createState() => _Kikisday15ScreenState();
}

class _Kikisday15ScreenState extends State<Kikisday15Screen> {
  @override
  Widget build(BuildContext context) {
    // 전달된 인자를 받기
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    int chips = arguments['chips'];

    return CardLayout(
      bgStr: 'assets/kikisday/kikisday_3_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      textStr: 'assets/kikisday/kikisday_15_text.png',
      cardStr: 'assets/kikisday/kikisday_red_card.png',
      completeScreen: KikisdayRedComplete2Screen(currentNumber: 15, chips: chips,),
      okBtnStr: 'assets/kikisday/kikisday_red_btn.png',
      timerColor: Color(0xFF868686),
      currentNumber: 15,
    );
  }
}
