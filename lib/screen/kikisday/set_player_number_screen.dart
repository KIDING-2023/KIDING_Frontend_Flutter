import 'package:flutter/material.dart';
import 'package:kiding/screen/kikisday/kikisday_tutorial1_screen.dart';
import 'package:provider/provider.dart';

import '../../model/timer_model.dart';
import '../layout/exit_layout.dart';

class SetPlayerNumberScreen extends StatefulWidget {
  const SetPlayerNumberScreen({super.key});

  @override
  State<SetPlayerNumberScreen> createState() => _SetPlayerNumberScreenState();
}

class _SetPlayerNumberScreenState extends State<SetPlayerNumberScreen> {
  int playerCount = 1; // 플레이어 숫자 초기값

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage("assets/kikisday/kikisday_tutorial1_bg.png"),
                    fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 45.0, left: 15.0, right: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ExitLayout(
                                  onKeepPressed: () {},
                                  onExitPressed: () {},
                                  isFromDiceOrCamera: false,
                                  isFromCard: true,
                                )),
                      );
                    },
                    icon: Image.asset('assets/kikisday/kikisday_back_btn.png',
                        width: screenWidth * 0.0366,
                        height: screenHeight * 0.025)),
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
          Positioned(
              left: 0,
              right: 0,
              top: screenHeight * 0.125,
              child: Image.asset('assets/kikisday/set_player_number_text.png',
                  width: screenWidth * 0.9439,
                  height: screenHeight * 0.326)),
          // 마이너스 버튼
          Positioned(
              top: screenHeight * 0.345,
              left: screenWidth * 0.29,
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (playerCount > 1) {
                        playerCount--;
                      }
                    });
                  },
                  icon: Image.asset(
                    'assets/kikisday/num_minus.png',
                    width: screenWidth * 0.0581,
                    height: screenHeight * 0.026,
                  ))),
          // 플레이어 숫자
          Positioned(
            top: screenHeight * 0.345,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(left: screenWidth * 0.4, right: screenWidth * 0.4),
              width: screenWidth * 0.19825,
              height: screenHeight * 0.052225,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/kikisday/num_bg.png'),
                fit: BoxFit.cover,
              )),
              child: Text(
                '$playerCount',
                style: TextStyle(
                  fontFamily: 'Nanum',
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          // 플러스 버튼
          Positioned(
              top: screenHeight * 0.345,
              right: screenWidth * 0.29,
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      playerCount++;
                    });
                  },
                  icon: Image.asset(
                    'assets/kikisday/num_plus.png',
                    width: screenWidth * 0.0581,
                    height: screenHeight * 0.026,
                  ))),
          Positioned(
              left: 0,
              right: 0,
              top: screenHeight * 0.4116375,
              child: Image.asset('assets/kikisday/kikisday_tutorial1_ch.png',
                  width: screenWidth, height: screenHeight * 0.4354875)),
          Positioned(
              left: 0,
              right: 0,
              bottom: screenHeight * 0.05,
              child: GestureDetector(
                child: Image.asset('assets/kikisday/kikisday_ok_btn.png',
                    width: screenWidth * 0.8946, height: screenHeight * 0.0559),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => KikisdayTutorial1Screen()));
                },
              )),
        ],
      ),
    );
  }
}
