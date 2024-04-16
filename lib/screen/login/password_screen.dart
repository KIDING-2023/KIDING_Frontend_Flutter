import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'login_splash_screen.dart';

class PasswordScreen extends StatefulWidget {
  final String nickname;
  final String phoneNumber;

  const PasswordScreen(
      {super.key, required this.nickname, required this.phoneNumber});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _pwController = TextEditingController();
  String errorMessage = "6글자 이상의 숫자로 입력하세요";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 비밀번호 설정 안내문
          Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Image.asset('assets/login/password_greeting_text.png',
                  width: 267.47, height: 128)),
          // 비밀번호 입력칸
          Positioned(
              top: 351.64,
              left: 0,
              right: 0,
              child: Image.asset('assets/login/nickname_box.png',
                  width: 261.32, height: 49.82)),
          Positioned(
              top: 351,
              left: 78,
              right: 0,
              child: TextField(
                controller: _pwController,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: '비밀번호를 입력하세요',
                    hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                    border: InputBorder.none),
                style: TextStyle(
                    fontFamily: 'nanum', fontSize: 17, color: Colors.black),
              )),
          // 비밀번호 에러 표시
          Positioned(
              top: 413.29,
              left: 76.46,
              child: Row(
                children: [
                  Visibility(
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
              )),
          // 입력 완료 버튼
          Positioned(
              top: 439.01,
              left: 0,
              right: 0,
              child: IconButton(
                onPressed: _pw,
                padding: EdgeInsets.zero,
                icon: Image.asset('assets/login/input_finish_btn.png',
                    width: 261.32, height: 49.82),
              )),
          // 진행 표시 선
          Positioned(
            top: 686.66,
            left: 48.9,
            child: Image.asset('assets/login/progress.png',
                width: 82.76, height: 4.5),
          ),
          Positioned(
            top: 686.66,
            left: 138.2,
            child: Image.asset('assets/login/progress.png',
                width: 82.76, height: 4.5),
          ),
          Positioned(
            top: 686.66,
            left: 227.5,
            child: Image.asset('assets/login/progress_colored.png',
                width: 82.76, height: 4.5),
          ),
        ],
      ),
    );
  }

  void _pw() async {
    String pw = _pwController.text;
    // 비밀번호 유효성 검사 로직
    if (pw.isEmpty) {
      setState(() {
        errorMessage = "비밀번호를 입력해주세요";
      });
    } else if (pw.length < 6 || _containsNonNumericOrSpecialCharacters(pw)) {
      setState(() {
        errorMessage = "6글자 이상의 숫자로 입력하세요";
      });
    } else {
      // Firebase 데이터베이스에 사용자 정보 저장
      final DatabaseReference dbRef = FirebaseDatabase.instance.ref("users");
      final userRef = dbRef.child(widget.phoneNumber); // 전화번호를 키로 사용
      userRef.set({
        'nickname': widget.nickname,
        'phone': widget.phoneNumber,
        'password': pw
      }).then((_) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginSplashScreen(nickname: widget.nickname, password: pw)),
        );
      }).catchError((error) {
        setState(() {
          errorMessage = '회원가입 중 문제가 발생했습니다: ${error.toString()}';
        });
      });
    }
  }

  bool _containsNonNumericOrSpecialCharacters(String s) {
    return RegExp(r'[^0-9]').hasMatch(s);
  }
}
