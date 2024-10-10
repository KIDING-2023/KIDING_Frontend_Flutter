import 'package:flutter/material.dart';
import 'package:kiding/screen/home/home_screen.dart';
import 'package:provider/provider.dart';

import '../../model/timer_model.dart';
import 'kikisday_tutorial1_screen.dart';

class FinishScreen extends StatefulWidget {
  const FinishScreen({super.key});

  @override
  State<FinishScreen> createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  int chipsResult = 30;

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
              'assets/kikisday/finish_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // 키딩칩 획득 이미지
          Positioned(
            top: screenHeight * 0.1639,
            left: 0,
            right: 0,
            child: Image.asset('assets/kikisday/finish_character.png',
                width: screenWidth * 0.9359, height: screenHeight * 0.5089),
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
              )),
          // 총 키딩칩 개수
          Positioned(
              top: screenHeight * 0.7178,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  chipsResult.toString() + '개',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Nanum',
                      color: Color(0xffff815b)),
                ),
              )),
          // 다시 플레이 & 홈으로 버튼
          Positioned(
              top: screenHeight * 0.8725,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 다시 플레이
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    KikisdayTutorial1Screen()));
                      },
                      icon: Image.asset(
                        'assets/kikisday/replay_btn.png',
                        width: screenWidth * 0.4013,
                        height: screenHeight * 0.0521,
                      )),
                  // 홈으로
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreen()));
                      },
                      icon: Image.asset(
                        'assets/kikisday/to_home_btn.png',
                        width: screenWidth * 0.4013,
                        height: screenHeight * 0.0521,
                      )),
                ],
              ))
        ],
      ),
    );
  }
}
