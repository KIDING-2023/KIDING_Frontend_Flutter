import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/timer_model.dart';
import 'kikisday_purple_complete_screen.dart';

class Kikisday16Screen extends StatefulWidget {
  const Kikisday16Screen({super.key, required int currentNumber});

  @override
  State<Kikisday16Screen> createState() => _Kikisday16ScreenState();
}

class _Kikisday16ScreenState extends State<Kikisday16Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // 배경 이미지
          Positioned.fill(
            child: Image.asset(
              'assets/kikisday/kikisday_4_bg.png',
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
          // 카드 텍스트 이미지
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            child: Image.asset('assets/kikisday/kikisday_16_text.png',
                width: 336.93, height: 118),
          ),
          // 카드 이미지
          Positioned(
            top: 270,
            left: 0,
            right: 0,
            child: Image.asset('assets/kikisday/kikisday_purple_card.png',
                width: 170.57, height: 239.34),
          ),
          // 버튼
          Positioned(
              top: 448.44,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  // complete 화면으로 전환합니다.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => KikisdayPurpleCompleteScreen(
                          currentNumber: 16,
                        )),
                  );
                },
                child: Image.asset('assets/kikisday/kikisday_purple_btn.png',
                    width: 120, height: 40.58),
              )),
          // mark
          Positioned(
            top: 505.86,
            left: 120,
            right: 205.91,
            bottom: 260.05,
            child: Image.asset('assets/kikisday/mark.png',
                width: 34.09, height: 34.09),
          ),
        ],
      ),
    );
  }
}
