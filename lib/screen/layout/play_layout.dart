import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiding_frontend/model/timer_mode.dart';
import 'package:provider/provider.dart';

class PlayLayout extends StatelessWidget {
  final String bg;
  final String backIcon;
  final String nextScreen;
  final String playBtn;

  const PlayLayout(
      {super.key,
      required this.bg,
      required this.backIcon,
      required this.nextScreen,
      required this.playBtn});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bg),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: screenHeight * 0.0375,
              left: screenWidth * 0.0417,
              child: Padding(
                  padding: EdgeInsets.only(top: 15.h),
                  child: IconButton(
                    icon: Image.asset(backIcon,
                        width: screenWidth * 0.0366,
                        height: screenHeight * 0.025),
                    onPressed: () {
                      final timerModel =
                          Provider.of<TimerModel>(context, listen: false);
                      timerModel.resetTimer(); // 타이머 종료
                      Navigator.pop(context);
                    },
                  )),
            ),
            // 플레이 버튼
            Positioned(
              bottom: screenHeight * 0.08,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  // 타이머 시작
                  final timerModel =
                      Provider.of<TimerModel>(context, listen: false);
                  timerModel.startTimer();
                  // 각 튜토리얼 화면으로 이동
                  Navigator.of(context).pushNamed(nextScreen);
                },
                child: Center(
                  child: Image.asset(playBtn, width: screenWidth * 0.75),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
