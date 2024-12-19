import 'package:flutter/material.dart';
import 'package:kiding_frontend/model/timer_mode.dart';
import 'package:kiding_frontend/screen/layout/exit_layout.dart';
import 'package:provider/provider.dart';

class SetPlayerOrderWidget extends StatelessWidget {
  final String bg;
  final String backBtn;
  final Color textColor;
  final String chImg;
  final Widget nextScreen;

  const SetPlayerOrderWidget(
      {super.key,
      required this.bg,
      required this.backBtn,
      required this.textColor,
      required this.chImg,
      required this.nextScreen});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage(bg), fit: BoxFit.cover)),
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
                    icon: Image.asset(backBtn,
                        width: screenWidth * 0.0366,
                        height: screenHeight * 0.025)),
                Consumer<TimerModel>(
                  // TimerModel의 현재 시간을 소비합니다.
                  builder: (context, timer, child) => Text(
                    timer.formattedTime, // TimerModel로부터 현재 시간을 가져옵니다.
                    style: TextStyle(
                      fontFamily: 'Nanum',
                      fontSize: 15,
                      color: textColor,
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
              child: Image.asset('assets/kikisday/set_player_order_text.png',
                  width: screenWidth * 0.9439, height: screenHeight * 0.2462)),
          // 캐릭터
          Positioned(
              left: 0,
              right: 0,
              top: screenHeight * 0.4116375,
              child: Image.asset(chImg,
                  width: screenWidth, height: screenHeight * 0.4354875)),
          // 확인 버튼
          Positioned(
              left: 0,
              right: 0,
              bottom: screenHeight * 0.05,
              child: GestureDetector(
                child: Image.asset('assets/kikisday/kikisday_ok_btn.png',
                    width: screenWidth * 0.8946, height: screenHeight * 0.0559),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => nextScreen));
                },
              )),
        ],
      ),
    );
  }
}
