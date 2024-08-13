import 'package:flutter/material.dart';
import 'package:kiding/screen/home/home_screen.dart';
import 'package:provider/provider.dart';

import '../../model/timer_model.dart';

class ExitLayout extends StatefulWidget {
  const ExitLayout({super.key});

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
                  onPressed: () => Navigator.pop(context),
                )),
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
                    final timerModel = Provider.of<TimerModel>(context, listen: false);
                    timerModel.resetTimer();  // 타이머 종료
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
