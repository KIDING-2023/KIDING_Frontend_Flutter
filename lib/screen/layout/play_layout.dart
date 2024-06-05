import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/timer_model.dart';

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
              top: 30.0,
              left: 30.0,
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context), // 홈 화면으로 돌아가기
                  child: Image.asset(backIcon, width: 13.16, height: 20.0),
                ),
              ),
            ),
            Positioned(
              bottom: 10.0,
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
                  child: Image.asset(playBtn, width: 300.0, height: 45.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
