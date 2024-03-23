import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/timer_model.dart';
import 'kikisday_pink_complete_screen.dart';

class Kikisday17Screen extends StatefulWidget {
  const Kikisday17Screen({super.key});

  @override
  State<Kikisday17Screen> createState() => _Kikisday17ScreenState();
}

class _Kikisday17ScreenState extends State<Kikisday17Screen> {
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
            child: Image.asset('assets/kikisday/kikisday_17_text.png',
                width: 336.93, height: 118),
          ),
          // 카드 이미지
          Positioned(
            top: 270,
            left: 0,
            right: 0,
            child: Image.asset('assets/kikisday/kikisday_pink_card.png',
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
                        builder: (context) => KikisdayPinkCompleteScreen(
                          currentNumber: 17,
                        )),
                  );
                },
                child: Image.asset('assets/kikisday/kikisday_pink_btn.png',
                    width: 120, height: 40.58),
              )),
        ],
      ),
    );
  }
}
