import 'package:flutter/material.dart';
import '../layout/card_layout.dart';
import 'kikisday_purple_complete_screen.dart';

class Kikisday18Screen extends StatefulWidget {
  const Kikisday18Screen({super.key});

  @override
  State<Kikisday18Screen> createState() => _Kikisday18ScreenState();
}

class _Kikisday18ScreenState extends State<Kikisday18Screen> {
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
      bgStr: 'assets/kikisday/kikisday_4_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      textStr: 'assets/kikisday/kikisday_18_text.png',
      cardStr: 'assets/kikisday/kikisday_purple_card.png',
      completeScreen: KikisdayPurpleCompleteScreen(currentNumber: 18, userId: userId),
      okBtnStr: 'assets/kikisday/kikisday_purple_btn.png',
      timerColor: Color(0xFF868686),
    );
  }
}
