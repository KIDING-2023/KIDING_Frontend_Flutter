import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiding_frontend/model/timer_mode.dart';
import 'package:provider/provider.dart';

class TalmudStoryLayout extends StatelessWidget {
  final String bgStr;
  final String backBtnStr;
  final Widget storyWid;
  final Color timerColor;
  final VoidCallback onBackButtonPressed;

  const TalmudStoryLayout(
      {super.key,
      required this.bgStr,
      required this.backBtnStr,
      required this.storyWid,
      required this.timerColor,
      required this.onBackButtonPressed});

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
              bgStr,
              fit: BoxFit.cover,
            ),
          ),
          // 뒤로 가기 버튼 및 타이머
          Positioned(
            top: screenHeight * 0.05625,
            left: screenWidth * 0.0417,
            right: screenWidth * 0.0833,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: onBackButtonPressed,
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
                      color: timerColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 스토리 텍스트 이미지
          Positioned(
            top: screenHeight * 0.15625,
            left: 0,
            right: 0,
            child: storyWid,
          ),
        ],
      ),
    );
  }
}
