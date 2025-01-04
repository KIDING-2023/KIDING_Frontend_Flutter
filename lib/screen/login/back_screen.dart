// 회원가입 과정에서 뒤로 가기 버튼 클릭 시 표시할 화면
import 'package:flutter/material.dart';
import 'package:kiding_frontend/screen/login/start_screen.dart';

class BackScreen extends StatefulWidget {
  const BackScreen({super.key});

  @override
  State<BackScreen> createState() => _BackScreenState();
}

class _BackScreenState extends State<BackScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; // 기기 화면 크기
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            // '회원가입을 진행중입니다' 텍스트
            Positioned(
              top: screenSize.height * 0.13,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/login/back_screen_text.png',
                width: screenSize.width * 0.74,
                height: screenSize.height * 0.11,
              ),
            ),
            // 중단 or 계속 버튼
            Positioned(
              top: screenSize.height * 0.44,
              left: 0,
              right: 0,
              child: Stack(
                children: [
                  // 버튼 배경 이미지
                  Center(
                      child: Image.asset(
                    'assets/login/back_btn_bg.png',
                    width: 259.96,
                    height: 120.99,
                  )),
                  // 버튼 세로 배치
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 중단 버튼
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StartScreen()));
                          },
                          icon: Image.asset(
                            'assets/login/to_start_btn.png',
                            width: 236.33,
                            height: 43.63,
                          ),
                        ),
                        // 계속 버튼
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Image.asset(
                            'assets/login/keep_signup_btn.png',
                            width: 236.33,
                            height: 43.63,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
