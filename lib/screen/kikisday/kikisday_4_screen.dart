import 'package:flutter/material.dart';
import '../layout/card_layout.dart';
import 'kikisday_green_complete_screen.dart';

class Kikisday4Screen extends StatefulWidget {
  const Kikisday4Screen({super.key});

  @override
  State<Kikisday4Screen> createState() => _Kikisday4ScreenState();
}

class _Kikisday4ScreenState extends State<Kikisday4Screen> {
  @override
  Widget build(BuildContext context) {
    return CardLayout(
        bgStr: 'assets/kikisday/kikisday_bg.png',
        backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
        textStr: 'assets/kikisday/kikisday_4_text.png',
        cardStr: 'assets/kikisday/kikisday_green_card.png',
        completeScreen: KikisdayGreenCompleteScreen(currentNumber: 4),
        okBtnStr: 'assets/kikisday/kikisday_green_btn.png');
  }
}
