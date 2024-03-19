import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kiding/screen/kikisday/talmud_question_2_screen.dart';
import 'package:provider/provider.dart';

import '../../model/timer_model.dart';

class KikisdayTalmudQuestion1Screen extends StatefulWidget {
  const KikisdayTalmudQuestion1Screen({super.key, required int currentNumber});

  @override
  State<KikisdayTalmudQuestion1Screen> createState() => _KikisdayTalmudQuestion1ScreenState();
}

class _KikisdayTalmudQuestion1ScreenState extends State<KikisdayTalmudQuestion1Screen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // 배경 이미지
          Positioned.fill(
            child: Image.asset(
              'assets/kikisday/kikisday_dice_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // 뒤로 가기 버튼 및 타이머
          Positioned(
            top: 45,
            left: 30,
            right: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset('assets/kikisday/kikisday_back_btn.png',
                      width: 13.16, height: 20.0),
                ),
                Consumer<TimerModel>(
                  // TimerModel의 현재 시간을 소비합니다.
                  builder: (context, timer, child) => Text(
                    timer.formattedTime, // TimerModel로부터 현재 시간을 가져옵니다.
                    style: TextStyle(
                      fontFamily: 'Nanum',
                      fontSize: 15,
                      color: Color(0xFF868686),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 질문 텍스트 이미지
          Positioned(
            top: 124.04,
            left: 0,
            right: 0,
            child: Image.asset('assets/kikisday/talmud_question_1_text.png',
                width: 339.79, height: 190.35),
          ),
          // 질문 캐릭터 이미지
          Positioned(
              top: 228.53,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  // complete 화면으로 전환합니다.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => KikisdayTalmudQuestion2Screen(
                          currentNumber: 1,
                        )),
                  );
                },
                child: Image.asset('assets/kikisday/talmud_question_1_ch.png',
                    width: 427.14, height: 413.36),
              )),
          // 눌러보기 버튼
          Positioned(
            top: 407.49,
            left: 234.87,
            right: 32.31,
            child: Image.asset('assets/kikisday/talmud_question_1_btn.png',
                width: 92.82, height: 80.44),
          ),
        ],
      ),
    );
  }
}
