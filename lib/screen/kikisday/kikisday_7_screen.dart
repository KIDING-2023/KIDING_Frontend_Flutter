import 'package:flutter/material.dart';
import '../layout/card_layout.dart';
import 'kikisday_skyblue_complete_screen.dart';

class Kikisday7Screen extends StatefulWidget {
  const Kikisday7Screen({super.key});

  @override
  State<Kikisday7Screen> createState() => _Kikisday7ScreenState();
}

class _Kikisday7ScreenState extends State<Kikisday7Screen> {
  @override
  Widget build(BuildContext context) {
    return CardLayout(
        bgStr: 'assets/kikisday/kikisday_2_bg.png',
        backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
        textStr: 'assets/kikisday/kikisday_7_text.png',
        cardStr: 'assets/kikisday/kikisday_skyblue_card.png',
        completeScreen: KikisdaySkyblueCompleteScreen(currentNumber: 7),
        okBtnStr: 'assets/kikisday/kikisday_skyblue_btn.png');
  }
}
