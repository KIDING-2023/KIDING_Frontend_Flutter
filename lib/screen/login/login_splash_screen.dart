import 'dart:async';
import 'package:flutter/material.dart';
import 'choose_character_screen.dart';

// '회원가입이 완료되었습니다.' 화면
class LoginSplashScreen extends StatefulWidget {
  final String nickname;  // 닉네임 받아오기
  final int userId; // userId 받아오기

  const LoginSplashScreen({required this.nickname, super.key, required this.userId});

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
          builder: (_) => ChooseCharacterScreen(nickname: widget.nickname, userId: widget.userId),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 'assets/login_splash_text.png' 이미지가 표시될 위치
              Text(
                '회원가입이 완료되었습니다',
                style: TextStyle(
                  fontFamily: 'nanum',
                  fontSize: 20,
                  color: Color(0xFF838383)
                ),
              )
              // 여기에 추가 UI 구성 요소가 위치할 수 있습니다.
            ],
          ),
        ),
      ),
    );
  }
}