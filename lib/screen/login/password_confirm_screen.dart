import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'back_screen.dart';
import 'login_splash_screen.dart';

class PasswordConfirmScreen extends StatefulWidget {
  final String nickname;
  final String phoneNumber;
  final String password;

  const PasswordConfirmScreen({super.key, required this.nickname, required this.phoneNumber, required this.password});

  @override
  State<PasswordConfirmScreen> createState() => _PasswordConfirmScreenState();
}

class _PasswordConfirmScreenState extends State<PasswordConfirmScreen> {
  final TextEditingController _pwController = TextEditingController();
  String errorMessage = "비밀번호를 다시 입력하세요";
  bool _isErrorVisible = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        // 뒤로가기 버튼
        Positioned(
          top: 30.0,
          left: 30.0,
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BackScreen()));
              },
              child: Image.asset('assets/kikisday/back_icon.png',
                  width: 13.16, height: 20.0),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 안내문
            Image.asset('assets/login/password_confirm_text.png',
                width: 267.47, height: 128),
            Column(
              // 비밀번호 입력 칸
              children: [
                Container(
                  width: screenSize.width * 0.7,
                  child: TextField(
                    controller: _pwController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: '비밀번호를 다시 입력하세요',
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
                  height: 5,
                ),
                // 비밀번호 오류 메시지
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: _isErrorVisible,
                      child: Icon(
                        Icons.circle,
                        size: 2.63,
                        fill: 1.0,
                        color: Color(0xFFFFA37C),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 5.0)),
                    Text(
                      errorMessage,
                      style: TextStyle(
                          fontFamily: 'nanum',
                          fontSize: 13,
                          color: Color(0xFFFFA37C)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                // 입력 완료 버튼
                IconButton(
                  onPressed: _pw,
                  padding: EdgeInsets.zero,
                  icon: Image.asset('assets/login/input_finish_btn.png',
                      width: screenSize.width * 0.7),
                ),
              ],
            ),
            // 진행 표시 선
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/login/progress.png',
                    width: 82.76, height: 4.5),
                SizedBox(
                  width: 5,
                ),
                Image.asset('assets/login/progress.png',
                    width: 82.76, height: 4.5),
                SizedBox(
                  width: 5,
                ),
                Image.asset('assets/login/progress_colored.png',
                    width: 82.76, height: 4.5),
              ],
            )
          ],
        ),
      ],
    ));
  }

  void _pw() async {
    String pw_test = _pwController.text;
    String pw = widget.password;
    // 비밀번호 확인 로직
    if (pw_test == pw) {
      setState(() {
        _isErrorVisible = true;
        errorMessage = "비밀번호가 일치하지 않습니다.";
      });
    } else {
      _signup();
    }
  }

  // API를 통한 회원가입 요청
  Future<void> _signup() async {
    String nickname = widget.nickname;
    String password = _pwController.text.trim();
    String phone = widget.phoneNumber; // 전화번호 입력 필드를 추가해야 합니다.

    var url = Uri.parse('http://3.37.76.76:8081/signup');
    var response = await http.post(url,
        body: jsonEncode(
            {'nickname': nickname, 'password': password, 'phone': phone}),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      // 성공적인 회원가입 처리, 로그인 화면으로 이동
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginSplashScreen(
                nickname: widget.nickname, password: password)),
      );
    } else {
      // 오류 메시지를 보여주는 로직
      setState(() {
        errorMessage = "회원가입에 실패했습니다.";
      });
    }
  }

  bool _containsNonNumericOrSpecialCharacters(String s) {
    return RegExp(r'[^0-9]').hasMatch(s);
  }
}
