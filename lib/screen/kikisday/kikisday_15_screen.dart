import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/timer_model.dart';
import 'kikisday_red_complete2_screen.dart';

class Kikisday15Screen extends StatefulWidget {
  const Kikisday15Screen({super.key, required int currentNumber});

  @override
  State<Kikisday15Screen> createState() => _Kikisday15ScreenState();
}

class _Kikisday15ScreenState extends State<Kikisday15Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // 배경 이미지
          Positioned.fill(
            child: Image.asset(
              'assets/kikisday/kikisday_3_bg.png',
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
            child: Image.asset('assets/kikisday/kikisday_15_text.png',
                width: 336.93, height: 118),
          ),
          // 카드 이미지
          Positioned(
            top: 270,
            left: 0,
            right: 0,
            child: Image.asset('assets/kikisday/kikisday_red_card.png',
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
                        builder: (context) => KikisdayRedComplete2Screen(
                          currentNumber: 15,
                        )),
                  );
                },
                child: Image.asset('assets/kikisday/kikisday_red_btn.png',
                    width: 120, height: 40.58),
              )),
          // mark
          Positioned(
            top: 278.44,
            left: 266.01,
            right: 31.45,
            bottom: 297.51,
            child: Image.asset('assets/kikisday/mark.png',
                width: 50.11, height: 50.11),
          ),
        ],
      ),
    );
  }
}
