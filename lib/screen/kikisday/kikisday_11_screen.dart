import 'package:flutter/material.dart';
import '../layout/card_layout.dart';
import 'kikisday_orange_complete2_screen.dart';

class Kikisday11Screen extends StatefulWidget {
  const Kikisday11Screen({super.key});

  @override
  State<Kikisday11Screen> createState() => _Kikisday11ScreenState();
}

class _Kikisday11ScreenState extends State<Kikisday11Screen> {
  @override
  Widget build(BuildContext context) {
    return CardLayout(
        bgStr: 'assets/kikisday/kikisday_3_bg.png',
        backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
        textStr: 'assets/kikisday/kikisday_11_text.png',
        cardStr: 'assets/kikisday/kikisday_orange_card.png',
        completeScreen: KikisdayOrangeComplete2Screen(currentNumber: 11),
        okBtnStr: 'assets/kikisday/kikisday_orange_btn.png');
  }
}
