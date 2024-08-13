import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/timer_model.dart';
import '../layout/card_layout.dart';
import 'kikisday_skyblue_complete_screen.dart';

class Kikisday8Screen extends StatefulWidget {
  const Kikisday8Screen({super.key});

  @override
  State<Kikisday8Screen> createState() => _Kikisday8ScreenState();
}

class _Kikisday8ScreenState extends State<Kikisday8Screen> {
  @override
  Widget build(BuildContext context) {
    return CardLayout(
      bgStr: 'assets/kikisday/kikisday_2_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      textStr: 'assets/kikisday/kikisday_8_text.png',
      cardStr: 'assets/kikisday/kikisday_skyblue_card.png',
      completeScreen: KikisdaySkyblueCompleteScreen(currentNumber: 8),
      okBtnStr: 'assets/kikisday/kikisday_skyblue_btn.png',
      timerColor: Color(0xFF868686),
      currentNumber: 8,
    );
  }
}
