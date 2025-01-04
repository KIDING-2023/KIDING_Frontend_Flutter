import 'package:flutter/material.dart';
import 'package:kiding_frontend/screen/login/back_screen.dart';
import 'package:kiding_frontend/screen/login/password_reset_confirm_screen.dart';

class PasswordResetScreen extends StatefulWidget {
  final String phone;

  const PasswordResetScreen({super.key, required this.phone});

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final TextEditingController _pwController =
      TextEditingController(); // 비밀번호 입력 컨트롤러
  String errorMessage = "6글자 이상의 숫자로 입력하세요"; // 에러 메시지 (항상 표시)

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Stack(
        children: [
          // 뒤로가기 버튼
          Positioned(
            top: screenSize.height * 0.06,
            left: screenSize.width * 0.03,
            child: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BackScreen()));
              },
              icon: Image.asset('assets/kikisday/back_icon.png',
                  width: screenSize.width * 0.04,
                  height: screenSize.height * 0.03),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // '비밀번호를 재설정해주세요' 텍스트
              Image.asset('assets/login/reset_pw_text.png',
                  width: screenSize.width * 0.74,
                  height: screenSize.height * 0.16),
              // 비밀번호 입력칸, 입력 완료 버튼
              Column(
                // 비밀번호 입력칸
                children: [
                  SizedBox(
                    width: 261.32,
                    height: 49.82,
                    child: TextField(
                      controller: _pwController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: '새 비밀번호를 입력해주세요',
                          hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                          filled: true,
                          fillColor: Color(0xfff6f6f6),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(100)),
                          contentPadding: EdgeInsets.all(20)),
                      style: TextStyle(
                        fontFamily: 'nanum',
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  // 비밀번호 오류 메시지
                  Row(
                    children: [
                      Padding(
                          padding:
                              EdgeInsets.only(left: screenSize.width * 0.21)),
                      Visibility(
                        child: Icon(
                          Icons.circle,
                          size: screenSize.width * 0.01,
                          fill: 1.0,
                          color: Color(0xFFFFA37C),
                        ),
                      ),
                      Padding(
                          padding:
                              EdgeInsets.only(left: screenSize.width * 0.01)),
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
                    height: screenSize.height * 0.01,
                  ),
                  // 입력 완료 버튼
                  IconButton(
                    onPressed: _pw,
                    padding: EdgeInsets.zero,
                    icon: Image.asset('assets/login/reset_pw_btn.png',
                        width: screenSize.width * 0.73),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ));
  }

  // 비밀번호 유효성 검사
  void _pw() async {
    String pw = _pwController.text;

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
            builder: (context) =>
                PasswordResetConfirmScreen(password: pw, phone: widget.phone)),
      );
    }
  }

  bool _containsNonNumericOrSpecialCharacters(String s) {
    return RegExp(r'[^0-9]').hasMatch(s);
  }
}
