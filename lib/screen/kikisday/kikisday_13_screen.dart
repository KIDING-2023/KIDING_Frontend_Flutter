import 'package:flutter/material.dart';
import '../layout/card_layout.dart';
import 'kikisday_yellow_complete_screen.dart';

class Kikisday13Screen extends StatefulWidget {
  const Kikisday13Screen({super.key});

  @override
  State<Kikisday13Screen> createState() => _Kikisday13ScreenState();
}

class _Kikisday13ScreenState extends State<Kikisday13Screen> {
  @override
  Widget build(BuildContext context) {
    return CardLayout(
        bgStr: 'assets/kikisday/kikisday_3_bg.png',
        backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
        textStr: 'assets/kikisday/kikisday_13_text.png',
        cardStr: 'assets/kikisday/kikisday_yellow_card.png',
        completeScreen: KikisdayYellowCompleteScreen(currentNumber: 13),
        okBtnStr: 'assets/kikisday/kikisday_yellow_btn.png');
  }
}
