import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/timer_model.dart';
import '../layout/card_layout.dart';
import 'kikisday_yellow_complete_screen.dart';

class Kikisday12Screen extends StatefulWidget {
  const Kikisday12Screen({super.key});

  @override
  State<Kikisday12Screen> createState() => _Kikisday12ScreenState();
}

class _Kikisday12ScreenState extends State<Kikisday12Screen> {
  @override
  Widget build(BuildContext context) {
    return CardLayout(
      bgStr: 'assets/kikisday/kikisday_3_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      textStr: 'assets/kikisday/kikisday_12_text.png',
      cardStr: 'assets/kikisday/kikisday_yellow_card.png',
      completeScreen: KikisdayYellowCompleteScreen(currentNumber: 12),
      okBtnStr: 'assets/kikisday/kikisday_yellow_btn.png',
      timerColor: Color(0xFF868686),
    );
  }
}
