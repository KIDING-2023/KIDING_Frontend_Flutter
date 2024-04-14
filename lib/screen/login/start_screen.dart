import 'package:flutter/material.dart';
import 'package:kiding/screen/home/home_screen.dart';
import 'package:kiding/screen/login/login_splash_screen.dart';
import 'package:kiding/screen/login/signup_screen.dart';

import 'find_nickname_screen.dart';
import 'find_password_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final _nicknameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isErrorVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 인삿말
          Positioned(
              top: 99.97,
              left: 0,
              right: 0,
              child: Image.asset('assets/login/start_greeting_text.png',
                  width: 248.78, height: 81.09)),
          // 닉네임 입력칸
          Positioned(
              top: 293.32,
              left: 0,
              right: 0,
              child: Image.asset('assets/login/nickname_box.png',
                  width: 261.38, height: 50.68)),
          Positioned(
              top: 293.32,
              left: 82.72,
              right: 0,
              child: TextField(
                controller: _nicknameController,
                decoration: InputDecoration(
                  hintText: '닉네임',
                  hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontFamily: 'nanum',
                  fontSize: 17,
                  color: Colors.black,
                ),
              )),
          // 비밀번호 입력칸
          Positioned(
              top: 351,
              left: 0,
              right: 0,
              child: Image.asset('assets/login/nickname_box.png',
                  width: 261.38, height: 50.68)),
          Positioned(
              top: 351,
              left: 82.72,
              right: 0,
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '비밀번호',
                  hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontFamily: 'nanum',
                  fontSize: 17,
                  color: Colors.black,
                ),
              )),
          // 시작하기 버튼
          Positioned(
              top: 412.54,
              left: 0,
              right: 0,
              child: Container(
                width: 261.32,
                height: 49.82,
                child: IconButton(
                  onPressed: _login,
                  padding: EdgeInsets.zero,
                  icon: Image.asset('assets/login/start_btn.png'),
                ),
              )),
          // 에러 메세지
          Positioned(
              top: 469.28,
              left: 0,
              right: 0,
              child: _isErrorVisible
                  ? Image.asset('assets/login/start_error_text.png',
                      width: 187.54, height: 36)
                  : SizedBox()),
          // 회원가입 버튼
          Positioned(
              top: 600.1,
              left: 67.36,
              child: Container(
                width: 69,
                height: 13,
                child: IconButton(
                  onPressed: _signup,
                  padding: EdgeInsets.zero,
                  icon: Image.asset('assets/login/to_signup_btn.png'),
                ),
              )),
          Positioned(
              top: 600.1,
              left: 143,
              child: Image.asset('assets/login/vertical_line.png',
                  width: 1.5, height: 14)),
          // 닉네임 찾기 버튼
          Positioned(
              top: 600.1,
              left: 150,
              child: Container(
                width: 57,
                height: 13,
                child: IconButton(
                  onPressed: _findNickname,
                  padding: EdgeInsets.zero,
                  icon: Image.asset('assets/login/to_find_nickname_btn.png'),
                ),
              )),
          Positioned(
              top: 600.1,
              left: 213.64,
              child: Image.asset('assets/login/vertical_line.png',
                  width: 1.5, height: 14)),
          // 비밀번호 찾기 버튼
          Positioned(
              top: 600.1,
              left: 220.64,
              child: Container(
                width: 72,
                height: 13,
                child: IconButton(
                  onPressed: _findPassword,
                  padding: EdgeInsets.zero,
                  icon: Image.asset('assets/login/to_find_password_btn.png'),
                ),
              )),
        ],
      ),
    );
  }

  // 닉네임과 비밀번호를 검증하는 로직 추가
  void _login() {
    String nickname = _nicknameController.text;
    String password = _passwordController.text;

    if (nickname == "전시원" && password == "5236cool") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  LoginSplashScreen(nickname: nickname, password: password)));
    } else {
      setState(() {
        _isErrorVisible = true;
      });
    }
  }

  // 회원가입 화면으로 이동
  void _signup() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignupScreen()));
  }

  // 닉네임 찾기 화면으로 이동
  void _findNickname() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FindNicknameScreen()));
  }

  // 비밀번호 찾기 화면으로 이동
  void _findPassword() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FindPasswordScreen()));
  }
}
