import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'choose_character_screen.dart';

// '회원가입이 완료되었습니다.' 화면
class LoginSplashScreen extends StatefulWidget {
  final String nickname;  // 닉네임 받아오기

  const LoginSplashScreen({required this.nickname, super.key});

  @override
  State<LoginSplashScreen> createState() => _LoginSplashScreenState();
}

class _LoginSplashScreenState extends State<LoginSplashScreen> {
  // Flutter Secure Storage 인스턴스 생성
  final storage = FlutterSecureStorage();
  String? token; // 불러온 토큰 저장할 변수

  @override
  void initState() {
    super.initState();
    _loadToken();  // 토큰 불러오기
  }

  // 토큰을 불러오는 메서드
  Future<void> _loadToken() async {
    token = await storage.read(key: 'accessToken'); // 저장된 토큰 불러오기
    if (token != null) {
      print("Token: $token");  // 토큰이 정상적으로 불러와졌는지 확인
    } else {
      print("토큰을 찾을 수 없습니다.");
    }

    // 토큰을 불러온 후 화면 전환 (2초 지연)
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ChooseCharacterScreen(
            nickname: widget.nickname, // 닉네임 전달
          ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
