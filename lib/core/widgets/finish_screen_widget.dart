import 'package:flutter/material.dart';

class FinishScreenBody extends StatelessWidget {
  final int chips;
  final double screenWidth;
  final double screenHeight;
  final Function onReplay;
  final Function onHome;
  final String bg;

  const FinishScreenBody({
    Key? key,
    required this.chips,
    required this.screenWidth,
    required this.screenHeight,
    required this.onReplay,
    required this.onHome,
    required this.bg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // 배경 이미지
        Positioned.fill(
          child: Image.asset(
            bg,
            fit: BoxFit.cover,
          ),
        ),
        // 키딩칩 획득 이미지
        Positioned(
          top: screenHeight * 0.1639,
          left: 0,
          right: 0,
          child: Image.asset(
            'assets/kikisday/finish_character.png',
            width: screenWidth * 0.9359,
            height: screenHeight * 0.5089,
          ),
        ),
        // 총 키딩칩 개수 배경
        Positioned(
          top: screenHeight * 0.6819,
          left: 0,
          right: 0,
          child: Image.asset(
            'assets/kikisday/chips_result_bg.png',
            width: screenWidth * 0.4726,
            height: screenHeight * 0.0846,
          ),
        ),
        // 총 키딩칩 개수
        Positioned(
          top: screenHeight * 0.714,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              '$chips개',
              style: TextStyle(
                fontSize: screenHeight * 0.0375,
                fontFamily: 'Nanum',
                color: Color(0xffff815b),
              ),
            ),
          ),
        ),
        // 다시 플레이 & 홈으로 버튼
        Positioned(
          top: screenHeight * 0.8725,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 다시 플레이 버튼
              IconButton(
                onPressed: () => onReplay(),
                icon: Image.asset(
                  'assets/kikisday/replay_btn.png',
                  width: screenWidth * 0.4013,
                  height: screenHeight * 0.0521,
                ),
              ),
              // 홈으로 버튼
              IconButton(
                onPressed: () => onHome(),
                icon: Image.asset(
                  'assets/kikisday/to_home_btn.png',
                  width: screenWidth * 0.4013,
                  height: screenHeight * 0.0521,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
