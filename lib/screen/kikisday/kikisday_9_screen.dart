import 'package:flutter/material.dart';
import '../layout/card_layout.dart';
import 'kikisday_red_complete_screen.dart';

class Kikisday9Screen extends StatefulWidget {
  const Kikisday9Screen({super.key});

  @override
  State<Kikisday9Screen> createState() => _Kikisday9ScreenState();
}

class _Kikisday9ScreenState extends State<Kikisday9Screen> {
  @override
  Widget build(BuildContext context) {
    // 전달된 인자를 받기
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    int chips = arguments['chips'];

    return CardLayout(
      bgStr: 'assets/kikisday/kikisday_2_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      textStr: 'assets/kikisday/kikisday_9_text.png',
      cardStr: 'assets/kikisday/kikisday_red_card.png',
      completeScreen: KikisdayRedCompleteScreen(currentNumber: 9, chips: chips,),
      okBtnStr: 'assets/kikisday/kikisday_red_btn.png',
      timerColor: Color(0xFF868686),
      currentNumber: 9,
      chips: chips,
    );
  }
}
