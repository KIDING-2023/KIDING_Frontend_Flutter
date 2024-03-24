import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/timer_model.dart';

class TutorialLayout extends StatelessWidget {
  final String bgStr;
  final String backBtnStr;
  final Color timerColorStr;
  final Widget textWid;
  final double chTopDouble;
  final Widget characterWid;
  final String okBtnStr;
  final String nextScreenStr;

  const TutorialLayout({super.key, required this.bgStr, required this.backBtnStr, required this.textWid, required this.chTopDouble, required this.characterWid, required this.okBtnStr, required this.nextScreenStr, required this.timerColorStr});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image:
                    AssetImage(bgStr),
                    fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 45.0, left: 30.0, right: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset(backBtnStr,
                      width: 13.16, height: 20.0),
                ),
                Consumer<TimerModel>(
                  // TimerModel의 현재 시간을 소비합니다.
                  builder: (context, timer, child) => Text(
                    timer.formattedTime, // TimerModel로부터 현재 시간을 가져옵니다.
                    style: TextStyle(
                      fontFamily: 'Nanum',
                      fontSize: 15,
                      color: timerColorStr,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              top: 125.22,
              child: textWid),
          Positioned(
              top: chTopDouble,
              child: characterWid),
          Positioned(
              left: 0,
              right: 0,
              top: 695,
              child: GestureDetector(
                child: Image.asset(okBtnStr,
                    width: 322.07, height: 44.75),
                onTap: () {
                  // 튜토리얼2로 이동
                  Navigator.of(context).pushNamed(nextScreenStr);
                },
              )),
        ],
      ),
    );
  }
}
