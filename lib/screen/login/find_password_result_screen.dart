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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // 안내문
          Image.asset('assets/login/password_result_text.png',
              width: 267.47, height: 88),
          Column(
            children: [
              // 비밀번호 찾기 결과
              Text(
                '비밀번호: ${widget.password}입니다.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'nanum', fontSize: 17, color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              // 로그인 & 닉네임 찾기 버튼
              Stack(
                children: [
                  // 배경 이미지
                  Center(child: Image.asset('assets/login/nickname_result_btn_bg.png', width: 259.96, height: 52.47,)),
                  // 버튼들을 가로로 배치하기 위한 Row
                  Center(
                    child: Container(
                      width: 250,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,  // 버튼들 사이의 공간을 균등하게 배분
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
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      )
    );
  }

  void _toLoginScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => StartScreen()));
  }

  void _toFindNicknameScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => FindNicknameScreen()));
  }
}
