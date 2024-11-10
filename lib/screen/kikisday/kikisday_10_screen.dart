import 'package:flutter/material.dart';
import '../layout/card_layout.dart';
import 'kikisday_skyblue_complete_screen.dart';

class Kikisday10Screen extends StatefulWidget {
  const Kikisday10Screen({super.key});

  @override
  State<Kikisday10Screen> createState() => _Kikisday10ScreenState();
}

class _Kikisday10ScreenState extends State<Kikisday10Screen> {
  @override
  Widget build(BuildContext context) {
    // 전달된 인자를 받기
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    int chips = arguments['chips'];
    
    return CardLayout(
      bgStr: 'assets/kikisday/kikisday_2_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      textStr: 'assets/kikisday/kikisday_10_text.png',
      cardStr: 'assets/kikisday/kikisday_skyblue_card.png',
      completeScreen: KikisdaySkyblueCompleteScreen(currentNumber: 10, chips: chips,),
      okBtnStr: 'assets/kikisday/kikisday_skyblue_btn.png',
      timerColor: Color(0xFF868686),
      currentNumber: 10,
      chips: chips,
    );
  }
}
