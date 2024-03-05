import 'dart:async';

import 'package:flutter/material.dart';

import 'choose_character_screen.dart';

class LoginSplashScreen extends StatefulWidget {
  final String nickname;

  const LoginSplashScreen({required this.nickname, super.key});

  @override
  State<LoginSplashScreen> createState() => _LoginSplashScreenState();
}

class _LoginSplashScreenState extends State<LoginSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ChooseCharacterScreen(nickname: widget.nickname),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 'assets/login_splash_text.png' 이미지가 표시될 위치
            Image.asset(
              'assets/login/login_splash_text.png', // 이미지 파일 경로를 확인하세요.
              width: 269.64,
              height: 40,
            ),
            // 여기에 추가 UI 구성 요소가 위치할 수 있습니다.
          ],
        ),
      ),
    );
  }
}