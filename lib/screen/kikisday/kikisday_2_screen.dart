import 'package:flutter/material.dart';
import 'package:kiding/screen/kikisday/kikisday_green_complete_screen.dart';
import 'package:kiding/screen/layout/card_layout.dart';

class Kikisday2Screen extends StatefulWidget {
  @override
  State<Kikisday2Screen> createState() => _Kikisday2ScreenState();
}

class _Kikisday2ScreenState extends State<Kikisday2Screen> {
  late int userId;

  @override
  void initState() {
    super.initState();

    // 인자를 추출합니다.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments as Map;
      if (args != null) {
        userId = args['userId']; // userId 인자 사용
        // userId를 사용한 추가 로직
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CardLayout(
      bgStr: 'assets/kikisday/kikisday_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      textStr: 'assets/kikisday/kikisday_2_text.png',
      cardStr: 'assets/kikisday/kikisday_green_card.png',
      completeScreen: KikisdayGreenCompleteScreen(currentNumber: 2, userId: userId),
      okBtnStr: 'assets/kikisday/kikisday_green_btn.png',
      timerColor: Color(0xFF868686),
    );
  }
}
