import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/timer_model.dart';
import 'exit_layout.dart';

class TutorialLayout extends StatelessWidget {
  final String bgStr;
  final String backBtnStr;
  final Color timerColorStr;
  final Widget textWid;
  final Widget characterWid;
  final String okBtnStr;
  final Widget nextScreen;

  const TutorialLayout(
      {super.key,
      required this.bgStr,
      required this.backBtnStr,
      required this.textWid,
      required this.characterWid,
      required this.okBtnStr,
      required this.nextScreen,
      required this.timerColorStr});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(bgStr), fit: BoxFit.cover)),
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
                        MaterialPageRoute(builder: (context) => ExitLayout()),
                      );
                    },
                    icon: Image.asset(backBtnStr, width: 13.16, height: 20.0)),
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
          Positioned(left: 0, right: 0, top: 100, child: textWid),
          Positioned(left: 0, right: 0, top: 320, child: characterWid),
          Positioned(
              left: 0,
              right: 0,
              bottom: 20,
              child: GestureDetector(
                child: Image.asset(okBtnStr, width: 322.07, height: 44.75),
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
