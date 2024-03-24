import 'package:flutter/material.dart';
import '../layout/card_layout.dart';
import 'kikisday_orange_complete_screen.dart';

class Kikisday6Screen extends StatefulWidget {
  const Kikisday6Screen({super.key});

  @override
  State<Kikisday6Screen> createState() => _Kikisday6ScreenState();
}

class _Kikisday6ScreenState extends State<Kikisday6Screen> {
  @override
  Widget build(BuildContext context) {
    return CardLayout(
        bgStr: 'assets/kikisday/kikisday_2_bg.png',
        backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
        textStr: 'assets/kikisday/kikisday_6_text.png',
        cardStr: 'assets/kikisday/kikisday_orange_card.png',
        completeScreen: KikisdayOrangeCompleteScreen(currentNumber: 6),
        okBtnStr: 'assets/kikisday/kikisday_orange_btn.png');
  }
}
