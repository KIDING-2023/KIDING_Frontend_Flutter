import 'package:flutter/material.dart';
import 'package:kiding_frontend/core/widgets/card_layout.dart';

class KikisdayCardScreen extends StatelessWidget {
  const KikisdayCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 전달된 인자를 받습니다.
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // 인자에서 필요한 값 추출
    final String bgStr = arguments['bgStr'];
    final String backBtnStr = arguments['backBtnStr'];
    final String textStr = arguments['textStr'];
    final String cardStr = arguments['cardStr'];
    final String okBtnStr = arguments['okBtnStr'];
    final Color timerColor = arguments['timerColor'];
    final int currentNumber = arguments['currentNumber'];
    final int chips = arguments['chips'];

    // CardLayout 위젯에 전달
    return CardLayout(
      bgStr: bgStr,
      backBtnStr: backBtnStr,
      textStr: textStr,
      cardStr: cardStr,
      okBtnStr: okBtnStr,
      timerColor: timerColor,
      currentNumber: currentNumber,
      chips: chips,
    );
  }
}
