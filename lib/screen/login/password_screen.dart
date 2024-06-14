
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kiding/screen/login/password_confirm_screen.dart';

import 'back_screen.dart';

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
                Image.asset('assets/login/password_greeting_text.png',
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
                            hintText: '비밀번호를 입력하세요',
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
                    Image.asset('assets/login/progress.png', width: 82.76, height: 4.5),
                    SizedBox(
                      width: 5,
                    ),
                    Image.asset('assets/login/progress.png', width: 82.76, height: 4.5),
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
      // 비밀번호 확인 화면으로 이동
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PasswordConfirmScreen(
                nickname: widget.nickname, password: _pwController.text.trim(), phoneNumber: widget.phoneNumber)),
      );
    }
  }

  bool _containsNonNumericOrSpecialCharacters(String s) {
    return RegExp(r'[^0-9]').hasMatch(s);
  }
}
