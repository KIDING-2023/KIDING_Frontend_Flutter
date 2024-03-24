import 'package:flutter/material.dart';
import '../layout/card_layout.dart';
import 'kikisday_pink_complete_screen.dart';

class Kikisday17Screen extends StatefulWidget {
  const Kikisday17Screen({super.key});

  @override
  State<Kikisday17Screen> createState() => _Kikisday17ScreenState();
}

class _Kikisday17ScreenState extends State<Kikisday17Screen> {
  @override
  Widget build(BuildContext context) {
    return CardLayout(
        bgStr: 'assets/kikisday/kikisday_4_bg.png',
        backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
        textStr: 'assets/kikisday/kikisday_17_text.png',
        cardStr: 'assets/kikisday/kikisday_pink_card.png',
        completeScreen: KikisdayPinkCompleteScreen(currentNumber: 17),
        okBtnStr: 'assets/kikisday/kikisday_pink_btn.png');
  }
}
