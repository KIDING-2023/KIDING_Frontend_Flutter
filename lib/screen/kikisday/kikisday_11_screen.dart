import 'package:flutter/material.dart';
import '../layout/card_layout.dart';
import 'kikisday_orange_complete2_screen.dart';

class Kikisday11Screen extends StatefulWidget {
  const Kikisday11Screen({super.key});

  @override
  State<Kikisday11Screen> createState() => _Kikisday11ScreenState();
}

class _Kikisday11ScreenState extends State<Kikisday11Screen> {
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
      bgStr: 'assets/kikisday/kikisday_3_bg.png',
      backBtnStr: 'assets/kikisday/kikisday_back_btn.png',
      textStr: 'assets/kikisday/kikisday_11_text.png',
      cardStr: 'assets/kikisday/kikisday_orange_card.png',
      completeScreen: KikisdayOrangeComplete2Screen(currentNumber: 11, userId: userId),
      okBtnStr: 'assets/kikisday/kikisday_orange_btn.png',
      timerColor: Color(0xFF868686),
    );
  }
}
