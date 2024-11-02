import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/game_provider.dart';
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
    // 전달된 인자를 받기
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    int chips = arguments['chips'];

    return CardLayout(
      bgStr: 'assets/kikisday/kikisday_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      textStr: 'assets/kikisday/kikisday_3_text.png',
      cardStr: 'assets/kikisday/kikisday_blue_card.png',
      completeScreen: KikisdayBlueCompleteScreen(
        currentNumber: 3,
        chips: chips,
      ),
      okBtnStr: 'assets/kikisday/kikisday_blue_btn.png',
      timerColor: Color(0xFF868686),
      currentNumber: 3,
    );
  }
}
