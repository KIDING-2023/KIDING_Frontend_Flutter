import 'package:flutter/material.dart';
import '../layout/card_layout.dart';
import 'kikisday_blue_complete_screen.dart';

class Kikisday5Screen extends StatefulWidget {
  const Kikisday5Screen({super.key});

  @override
  State<Kikisday5Screen> createState() => _Kikisday5ScreenState();
}

class _Kikisday5ScreenState extends State<Kikisday5Screen> {
  @override
  Widget build(BuildContext context) {
    // 전달된 인자를 받기
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    int chips = arguments['chips'];

    return CardLayout(
      bgStr: 'assets/kikisday/kikisday_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      textStr: 'assets/kikisday/kikisday_5_text.png',
      cardStr: 'assets/kikisday/kikisday_blue_card.png',
      completeScreen: KikisdayBlueCompleteScreen(currentNumber: 5, chips: chips,),
      okBtnStr: 'assets/kikisday/kikisday_blue_btn.png',
      timerColor: Color(0xFF868686),
      currentNumber: 5,
      chips: chips,
    );
  }
}
