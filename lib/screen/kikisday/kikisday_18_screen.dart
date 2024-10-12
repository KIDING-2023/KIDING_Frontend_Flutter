import 'package:flutter/material.dart';
import '../layout/card_layout.dart';
import 'kikisday_purple_complete_screen.dart';

class Kikisday18Screen extends StatefulWidget {
  const Kikisday18Screen({super.key});

  @override
  State<Kikisday18Screen> createState() => _Kikisday18ScreenState();
}

class _Kikisday18ScreenState extends State<Kikisday18Screen> {
  @override
  Widget build(BuildContext context) {
    // 전달된 인자를 받기
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    int chips = arguments['chips'];

    return CardLayout(
      bgStr: 'assets/kikisday/kikisday_4_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      textStr: 'assets/kikisday/kikisday_18_text.png',
      cardStr: 'assets/kikisday/kikisday_purple_card.png',
      completeScreen: KikisdayPurpleCompleteScreen(currentNumber: 18, chips: chips,),
      okBtnStr: 'assets/kikisday/kikisday_purple_btn.png',
      timerColor: Color(0xFF868686),
      currentNumber: 18,
    );
  }
}
