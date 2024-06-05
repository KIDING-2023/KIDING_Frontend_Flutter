import 'package:flutter/material.dart';
import 'package:kiding/screen/home/home_screen.dart';
import 'package:kiding/screen/login/login_splash_screen.dart';
import 'package:kiding/screen/login/signup_screen.dart';
import 'package:mysql1/mysql1.dart';

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
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // 인삿말
          Image.asset('assets/login/start_greeting_text.png',
              width: 248.78, height: 81.09),
          // 닉네임 입력칸
          Column(
            children: [
              Container(
                width: screenSize.width * 0.7,
                child: TextField(
                  controller: _nicknameController,
                  decoration: InputDecoration(
                      hintText: '닉네임',
                      hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(100)),
                      contentPadding: EdgeInsets.only(left: 20)),
                  style: TextStyle(
                    fontFamily: 'nanum',
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // 비밀번호 입력칸
              Container(
                width: screenSize.width * 0.7,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: '비밀번호',
                      hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(100)),
                      contentPadding: EdgeInsets.only(left: 20)),
                  style: TextStyle(
                    fontFamily: 'nanum',
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // 시작하기 버튼
              Container(
                width: screenSize.width * 0.7,
                child: IconButton(
                  onPressed: _login,
                  padding: EdgeInsets.zero,
                  icon: Image.asset('assets/login/start_btn.png'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // 에러 메세지
              Container(
                  child: _isErrorVisible
                      ? Image.asset('assets/login/start_error_text.png',
                      width: 187.54, height: 36)
                      : SizedBox()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 회원가입 버튼
              Container(
                width: 69,
                height: 13,
                child: IconButton(
                  onPressed: _signup,
                  padding: EdgeInsets.zero,
                  icon: Image.asset('assets/login/to_signup_btn.png'),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Image.asset('assets/login/vertical_line.png',
                  width: 1.5, height: 14),
              SizedBox(
                width: 5,
              ),
              // 닉네임 찾기 버튼
              Container(
                width: 57,
                height: 13,
                child: IconButton(
                  onPressed: _findNickname,
                  padding: EdgeInsets.zero,
                  icon: Image.asset('assets/login/to_find_nickname_btn.png'),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Image.asset('assets/login/vertical_line.png',
                  width: 1.5, height: 14),
              SizedBox(
                width: 5,
              ),
              // 비밀번호 찾기 버튼
              Container(
                width: 72,
                height: 13,
                child: IconButton(
                  onPressed: _findPassword,
                  padding: EdgeInsets.zero,
                  icon: Image.asset('assets/login/to_find_password_btn.png'),
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }

  // 닉네임과 비밀번호를 검증하는 로직 추가
  Future<void> _login() async {
    String nickname = _nicknameController.text.trim();
    String password = _passwordController.text.trim();

    if (nickname == "전시원" && password == "5236cool") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
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
