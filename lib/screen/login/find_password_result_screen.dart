import 'package:flutter/material.dart';
import 'package:kiding/screen/login/start_screen.dart';

import 'find_nickname_screen.dart';

class FindPasswordResultScreen extends StatefulWidget {
  final String password;

  const FindPasswordResultScreen({super.key, required this.password});

  @override
  State<FindPasswordResultScreen> createState() => _FindPasswordResultScreenState();
}

class _FindPasswordResultScreenState extends State<FindPasswordResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 상단 안내문
          Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Image.asset('assets/login/password_result_text.png',
                  width: 267.47, height: 88)),
          // 비밀번호 찾기 결과
          Positioned(
              top: 367.71,
              left: 0,
              right: 0,
              child: Text(
                '비밀번호: ${widget.password}입니다.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'nanum', fontSize: 17, color: Colors.black),
              )),
          // 로그인 & 닉네임 찾기 버튼
          Positioned(
            top: 405.85,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 259.96,
                height: 52.47,
                child: Stack(
                  children: [
                    // 배경 이미지
                    Image.asset('assets/login/nickname_result_btn_bg.png', fit: BoxFit.cover),
                    // 버튼들을 가로로 배치하기 위한 Row
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,  // 버튼들 사이의 공간을 균등하게 배분
                        children: [
                          // 로그인 버튼
                          IconButton(
                            onPressed: _toLoginScreen,
                            padding: EdgeInsets.zero,
                            icon: Image.asset('assets/login/nickname_login_btn.png',
                                width: 121.11, height: 43.63),
                          ),
                          // 닉네임 찾기 버튼
                          IconButton(
                            onPressed: _toFindNicknameScreen,
                            padding: EdgeInsets.zero,
                            icon: Image.asset('assets/login/password_nickname_btn.png',
                                width: 121.11, height: 43.63),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _toLoginScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => StartScreen()));
  }

  void _toFindNicknameScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => FindNicknameScreen()));
  }
}
