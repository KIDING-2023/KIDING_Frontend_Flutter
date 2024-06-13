import 'package:flutter/material.dart';
import 'package:kiding/screen/login/find_nickname_screen.dart';
import 'package:kiding/screen/login/start_screen.dart';

class BackScreen extends StatefulWidget {
  const BackScreen({super.key});

  @override
  State<BackScreen> createState() => _BackScreenState();
}

class _BackScreenState extends State<BackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            'assets/login/back_screen_text.png',
            width: 267.47,
            height: 88,
          ),
          // 닉네임 찾기 & 비밀번호 찾기 버튼
          Stack(
            children: [
              // 배경 이미지
              Center(
                  child: Image.asset(
                'assets/login/back_btn_bg.png',
                width: 259.96,
                height: 120.99,
              )),
              // 버튼들을 세로로 배치하기 위한 Column
              Center(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween, // 버튼들 사이의 공간을 균등하게 배분
                      children: [
                        // 처음 화면으로 버튼
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StartScreen()));
                          },
                          padding: EdgeInsets.zero,
                          icon: Image.asset('assets/login/to_start_btn.png',
                              width: 236.33, height: 43.63),
                        ),
                        // 닉네임 찾기 버튼
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          padding: EdgeInsets.zero,
                          icon: Image.asset(
                              'assets/login/keep_signup_btn.png',
                              width: 236.33,
                              height: 43.63),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }
}
