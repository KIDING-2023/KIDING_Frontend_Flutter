import 'package:flutter/material.dart';
import '../layout/card_layout.dart';
import 'kikisday_green_complete_screen.dart';

class Kikisday4Screen extends StatefulWidget {
  const Kikisday4Screen({super.key});

  @override
  State<Kikisday4Screen> createState() => _Kikisday4ScreenState();
}

class _Kikisday4ScreenState extends State<Kikisday4Screen> {
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
      textStr: 'assets/kikisday/kikisday_4_text.png',
      cardStr: 'assets/kikisday/kikisday_green_card.png',
      completeScreen: KikisdayGreenCompleteScreen(currentNumber: 4, userId: userId,),
      okBtnStr: 'assets/kikisday/kikisday_green_btn.png',
      timerColor: Color(0xFF868686),
    );
  }
}
