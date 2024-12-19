import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kiding_frontend/model/game_provider.dart';
import 'package:kiding_frontend/model/timer_mode.dart';
import 'package:kiding_frontend/screen/layout/exit_layout.dart';
import 'package:provider/provider.dart';

class SetPlayerNumWidget extends StatefulWidget {
  final String bg;
  final String bacnBtn;
  final Color textColor;
  final String chImg;
  final String gameName;
  final Widget nextScreen;

  const SetPlayerNumWidget({
    super.key,
    required this.bg,
    required this.bacnBtn,
    required this.textColor,
    required this.chImg,
    required this.gameName,
    required this.nextScreen,
  });

  @override
  State<SetPlayerNumWidget> createState() => _SetPlayerNumWidgetState();
}

class _SetPlayerNumWidgetState extends State<SetPlayerNumWidget> {
  int playerCount = 1; // 플레이어 숫자 초기값

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context); // gameProvider 추가
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(widget.bg), // 배경
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
                    icon: Image.asset(widget.bacnBtn, // 뒤로가기 버튼
                        width: screenWidth * 0.0366,
                        height: screenHeight * 0.025)),
                Consumer<TimerModel>(
                  // TimerModel의 현재 시간을 소비합니다.
                  builder: (context, timer, child) => Text(
                    timer.formattedTime, // TimerModel로부터 현재 시간을 가져옵니다.
                    style: TextStyle(
                      fontFamily: 'Nanum',
                      fontSize: 15,
                      color: widget.textColor, // 글자 색 (타이머 색)
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
                  width: screenWidth * 0.9439, height: screenHeight * 0.326)),
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
                  ))),
          // 플레이어 숫자
          Positioned(
            top: screenHeight * 0.345,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(
                  left: screenWidth * 0.4, right: screenWidth * 0.4),
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
                      if (playerCount <= 3) playerCount++;
                    });
                  },
                  icon: Image.asset(
                    'assets/kikisday/num_plus.png',
                    width: screenWidth * 0.0581,
                  ))),
          Positioned(
              left: 0,
              right: 0,
              top: screenHeight * 0.4116375,
              child: Image.asset(widget.chImg, // 캐릭터 이미지
                  width: screenWidth,
                  height: screenHeight * 0.4354875)),
          Positioned(
              left: 0,
              right: 0,
              bottom: screenHeight * 0.05,
              child: GestureDetector(
                child: Image.asset('assets/kikisday/kikisday_ok_btn.png',
                    width: screenWidth * 0.8946, height: screenHeight * 0.0559),
                onTap: () {
                  gameProvider.setPlayers(playerCount);
                  log("${widget.gameName} 플레이어 수 설정 완료: ${gameProvider.players.length}"); // 설정된 플레이어 수 확인
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => widget.nextScreen));
                },
              )),
        ],
      ),
    );
  }
}
