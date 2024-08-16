import 'package:flutter/material.dart';
import 'package:kiding/screen/home/home_screen.dart';
import 'package:provider/provider.dart';

import '../../model/timer_model.dart';

class ExitLayout extends StatefulWidget {
  final VoidCallback onKeepPressed;
  final VoidCallback onExitPressed;
  final bool isFromDiceOrCamera;
  final bool isFromCard;

  const ExitLayout(
      {super.key,
      required this.onKeepPressed,
      required this.onExitPressed,
      required this.isFromDiceOrCamera, required this.isFromCard});

  @override
  State<ExitLayout> createState() => _ExitLayoutState();
}

class _ExitLayoutState extends State<ExitLayout> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/exit/background.png'),
                fit: BoxFit.cover)),
        child: Stack(
          children: [
            Positioned(
                top: screenHeight * 0.45,
                left: 0,
                right: 0,
                child: IconButton(
                    icon: Image.asset(
                      'assets/exit/keep_btn.png',
                      width: screenWidth * 0.6,
                      height: screenHeight * 0.05,
                    ),
                    onPressed: () {
                      Navigator.pop(context); // 이전 화면으로 돌아가기
                      if (!widget.isFromCard) {
                        widget.onKeepPressed(); // 타이머 재개
                      }
                    })),
            Positioned(
                top: screenHeight * 0.51,
                left: 0,
                right: 0,
                child: IconButton(
                  icon: Image.asset(
                    'assets/exit/exit_btn.png',
                    width: screenWidth * 0.6,
                    height: screenHeight * 0.05,
                  ),
                  onPressed: () {
                    final timerModel =
                        Provider.of<TimerModel>(context, listen: false);
                    timerModel.resetTimer(); // 타이머 종료
                    if (widget.isFromDiceOrCamera) {
                      widget.onExitPressed(); // 주사위 또는 카메라 종료
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}
