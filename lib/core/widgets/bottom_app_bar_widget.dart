import 'package:flutter/material.dart';

import '../../screen/home/home_screen.dart';
import '../../screen/mypage/mypage_screen.dart';
import '../../screen/ranking/ranking_screen.dart';

class BottomAppBarWidget extends StatelessWidget {
  final double topPosition;
  final double screenHeight;
  final double screenWidth;
  final String screen;
  final bool hasAppBar;

  const BottomAppBarWidget({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.screen,
    required this.topPosition, required this.hasAppBar,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: topPosition,
      left: 0,
      right: 0,
      child: Container(
        height: hasAppBar ? screenHeight * 0.06 : screenHeight * 0.09,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Image.asset(
                'assets/${screen}/ranking_icon.png',
                width: screenWidth * 0.1,
                height: screenHeight * 0.04,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RankingScreen(),
                  ),
                );
              },
            ),
            IconButton(
              icon: Image.asset(
                'assets/${screen}/home_icon.png',
                width: screenWidth * 0.1,
                height: screenHeight * 0.04,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
            ),
            IconButton(
              icon: Image.asset(
                'assets/${screen}/mypage_icon.png',
                width: screenWidth * 0.1,
                height: screenHeight * 0.04,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyPageScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
