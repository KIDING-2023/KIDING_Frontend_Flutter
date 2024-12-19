import 'package:flutter/material.dart';
import 'package:kiding_frontend/model/timer_mode.dart';
import 'package:kiding_frontend/screen/kikisday/talmud_question_2_screen.dart';
import 'package:provider/provider.dart';

class KikisdayTalmudQuestion1Screen extends StatefulWidget {
  const KikisdayTalmudQuestion1Screen({super.key});

  @override
  State<KikisdayTalmudQuestion1Screen> createState() =>
      _KikisdayTalmudQuestion1ScreenState();
}

class _KikisdayTalmudQuestion1ScreenState
    extends State<KikisdayTalmudQuestion1Screen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          // 배경 이미지
          Positioned.fill(
            child: Image.asset(
              'assets/kikisday/kikisday_1_dice_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // 뒤로 가기 버튼 및 타이머
          Positioned(
            top: screenHeight * 0.05625,
            left: screenWidth * 0.0833,
            right: screenWidth * 0.0833,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset('assets/kikisday/kikisday_back_btn.png',
                      width: screenWidth * 0.0366,
                      height: screenHeight * 0.025),
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
            top: screenHeight * 0.15505,
            left: 0,
            right: 0,
            child: Image.asset('assets/kikisday/talmud_question_1_text.png',
                width: screenWidth * 0.9439, height: screenHeight * 0.2379),
          ),
          // 질문 캐릭터 이미지
          Positioned(
              top: screenHeight * 0.2857,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  // complete 화면으로 전환합니다.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => KikisdayTalmudQuestion2Screen()),
                  );
                },
                child: Image.asset('assets/kikisday/talmud_question_1_ch.png',
                    width: screenWidth * 1.1865, height: screenHeight * 0.5167),
              )),
          // 눌러보기 버튼
          Positioned(
            top: screenHeight * 0.5094,
            left: screenWidth * 0.6524,
            right: screenWidth * 0.08975,
            child: Image.asset('assets/kikisday/talmud_question_1_btn.png',
                width: screenWidth * 0.2578, height: screenHeight * 0.10055),
          ),
        ],
      ),
    );
  }
}
