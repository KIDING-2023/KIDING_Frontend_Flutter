import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiding_frontend/model/timer_mode.dart';
import 'package:kiding_frontend/screen/layout/exit_layout.dart';
import 'package:provider/provider.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(bgStr), fit: BoxFit.cover)),
          ),
          Padding(
            padding: EdgeInsets.only(top: 45.h, left: 15.w, right: 30.w),
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
                    icon: Image.asset(backBtnStr,
                        width: screenWidth * 0.0366,
                        height: screenHeight * 0.025)),
                Consumer<TimerModel>(
                  // TimerModel의 현재 시간을 소비합니다.
                  builder: (context, timer, child) => Text(
                    timer.formattedTime, // TimerModel로부터 현재 시간을 가져옵니다.
                    style: TextStyle(
                      fontFamily: 'Nanum',
                      fontSize: 15.sp,
                      color: timerColorStr,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              left: 0, right: 0, top: screenHeight * 0.125, child: textWid),
          Positioned(
              left: 0, right: 0, top: screenHeight * 0.4, child: characterWid),
          Positioned(
              left: 0,
              right: 0,
              bottom: screenHeight * 0.07,
              child: GestureDetector(
                child: Image.asset(okBtnStr,
                    width: screenWidth * 0.8946, height: screenHeight * 0.0559),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => nextScreen,
                        settings: RouteSettings(arguments: {
                          'position': 0,
                          'chips': 0,
                        }),
                      ));
                },
              )),
        ],
      ),
    );
  }
}
