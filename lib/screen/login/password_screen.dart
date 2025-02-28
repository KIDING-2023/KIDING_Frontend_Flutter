// 회원가입 비밀번호 설정 화면
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiding_frontend/screen/login/back_screen.dart';
import 'package:kiding_frontend/screen/login/password_confirm_screen.dart';

class PasswordScreen extends StatefulWidget {
  final String nickname; // 닉네임 받아오기
  final String phoneNumber; // 전화번호 받아오기

  const PasswordScreen(
      {super.key, required this.nickname, required this.phoneNumber});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
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
              // '비밀번호를 설정해주세요' 텍스트
              Image.asset('assets/login/password_greeting_text.png',
                  width: screenSize.width * 0.74,
                  height: screenSize.height * 0.16),
              // 비밀번호 입력칸, 입력 완료 버튼
              Column(
                // 비밀번호 입력칸
                children: [
                  SizedBox(
                    width: 261.32.w,
                    height: 49.82.h,
                    child: TextField(
                      controller: _pwController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: '비밀번호를 입력하세요',
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
                            fontSize: 13.sp,
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
                    icon: Image.asset('assets/login/input_finish_btn.png',
                        width: screenSize.width * 0.73),
                  ),
                ],
              ),
              // 진행 표시 선
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/login/progress.png',
                      width: screenSize.width * 0.23,
                      height: screenSize.height * 0.01),
                  SizedBox(
                    width: screenSize.width * 0.02,
                  ),
                  Image.asset('assets/login/progress.png',
                      width: screenSize.width * 0.23,
                      height: screenSize.height * 0.01),
                  SizedBox(
                    width: screenSize.width * 0.02,
                  ),
                  Image.asset('assets/login/progress_colored.png',
                      width: screenSize.width * 0.23,
                      height: screenSize.height * 0.01),
                ],
              )
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
            builder: (context) => PasswordConfirmScreen(
                nickname: widget.nickname,
                password: _pwController.text.trim(),
                phoneNumber: widget.phoneNumber)),
      );
    }
  }

  bool _containsNonNumericOrSpecialCharacters(String s) {
    return RegExp(r'[^0-9]').hasMatch(s);
  }
}
