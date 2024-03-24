import 'package:flutter/material.dart';
import '../layout/card_layout.dart';
import 'kikisday_blue_complete_screen.dart';

class Kikisday3Screen extends StatefulWidget {
  const Kikisday3Screen({super.key});

  @override
  State<Kikisday3Screen> createState() => _Kikisday3ScreenState();
}

class _Kikisday3ScreenState extends State<Kikisday3Screen> {
  @override
  Widget build(BuildContext context) {
    return CardLayout(
        bgStr: 'assets/kikisday/kikisday_bg.png',
        backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
        textStr: 'assets/kikisday/kikisday_3_text.png',
        cardStr: 'assets/kikisday/kikisday_blue_card.png',
        completeScreen: KikisdayBlueCompleteScreen(currentNumber: 3),
        okBtnStr: 'assets/kikisday/kikisday_blue_btn.png');
  }
}
