import 'package:flutter/material.dart';

import 'login_splash_screen.dart';

class PasswordScreen extends StatefulWidget {
  final String nickname;

  const PasswordScreen({super.key, required this.nickname});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _pwController = TextEditingController();
  late String _inputErrorText = "6글자 이상의 숫자로 입력하세요";
  bool _isObscure = true; // 비밀번호 가시성 제어

  void _togglePasswordVisibility() {
    // 비밀번호 가시성 상태를 토글
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Center( // This widget is positioned at the top of the Column
              child: Image.asset(
                'assets/login/password_greeting_text.png',
                width: 267.47,
                height: 120.0,
              ),
            ),
          ),
          Positioned(
            top: 351.64,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,// Takes up as little space as possible
              children: <Widget>[
                Container(
                  width: 261.32,
                  height: 49.82,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.91),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x26000000),
                        blurRadius: 1.75,
                        offset: Offset(0, 0.87),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: _pwController,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      labelText: '비밀번호를 입력하세요',
                      alignLabelWithHint: true, // 레이블을 hint와 정렬
                      labelStyle: TextStyle(color: Color(0xFFAAAAAA)),
                      floatingLabelBehavior: FloatingLabelBehavior.never, // 항상 레이블 표시
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 26.22),
                      // 가시성 토글 버튼 추가
                      suffixIcon: IconButton(
                        icon: Icon(
                          // 가시성 상태에 따라 아이콘 변경
                          _isObscure ? Icons.visibility_off : Icons.visibility,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: _togglePasswordVisibility, // 버튼 클릭 시 함수 호출
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: 'Nanum',
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 17.08),
                Container(
                  width: 195.23,
                  height: 14.11,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Visibility(
                        child: Image.asset('assets/login/eclipse.png'),
                      ),
                      SizedBox(width: 4.82),
                      Text(
                        _inputErrorText ?? '',
                        style: TextStyle(
                          fontFamily: 'Nanum',
                          fontSize: 13,
                          color: Color(0xFFFFA37C),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 9.85),
                ElevatedButton(
                  onPressed: _pw,
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFFF6A2B),
                    minimumSize: Size(261.32, 49.82),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text(
                    '시작하기',
                    style: TextStyle(
                      fontFamily: 'Nanum',
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  void _pw() {
    String pw = _pwController.text;
    // 비밀번호 유효성 검사 로직ㅇ

    if (pw.isEmpty) {
      setState(() {
        _inputErrorText = "비밀번호를 입력해주세요";
      });
    } else if (pw.length < 6 || _containsNonNumericOrSpecialCharacters(pw)) {
      setState(() {
        _inputErrorText = "6글자 이상의 숫자로 입력하세요";
      });
    } else {
      //_doSignup(nickname);
      // 회원가입 성공 처리
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginSplashScreen(
              nickname: widget.nickname,
              password: pw
            )),
      );
    }
  }

  bool _containsNonNumericOrSpecialCharacters(String s) {
    return RegExp(r'[^0-9]').hasMatch(s);
  }

}
