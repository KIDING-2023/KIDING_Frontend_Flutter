import 'package:flutter/material.dart';
import '../layout/card_layout.dart';
import 'kikisday_purple_complete_screen.dart';

class Kikisday16Screen extends StatefulWidget {
  const Kikisday16Screen({super.key});

  @override
  State<Kikisday16Screen> createState() => _Kikisday16ScreenState();
}

class _Kikisday16ScreenState extends State<Kikisday16Screen> {
  @override
  Widget build(BuildContext context) {
    return CardLayout(
        bgStr: 'assets/kikisday/kikisday_4_bg.png',
        backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
        textStr: 'assets/kikisday/kikisday_16_text.png',
        cardStr: 'assets/kikisday/kikisday_purple_card.png',
        completeScreen: KikisdayPurpleCompleteScreen(currentNumber: 16),
        okBtnStr: 'assets/kikisday/kikisday_purple_btn.png');
  }
}
