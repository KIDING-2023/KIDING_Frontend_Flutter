import 'package:flutter/material.dart';
import 'package:kiding_frontend/screen/home/home_screen.dart';
import 'package:kiding_frontend/screen/mypage/mypage_screen.dart';
import 'package:kiding_frontend/screen/ranking/ranking_screen.dart';

class BottomAppBarWidget extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final String screen;
  final bool hasAppBar;

  const BottomAppBarWidget({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.screen,
    required this.hasAppBar,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // 배경색 설정
          border: const Border(
            top: BorderSide(color: Colors.grey, width: 0.5), // 상단 테두리만 추가
          ),
        ),
        height: hasAppBar ? screenHeight * 0.06 : screenHeight * 0.09,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Image.asset(
                'assets/$screen/ranking_icon.png',
                width: screenWidth * 0.1,
                height: screenHeight * 0.04,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RankingScreen(),
                  ),
                );
              },
            ),
            IconButton(
              icon: Image.asset(
                'assets/$screen/home_icon.png',
                width: screenWidth * 0.1,
                height: screenHeight * 0.04,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
            ),
            IconButton(
              icon: Image.asset(
                'assets/$screen/mypage_icon.png',
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
