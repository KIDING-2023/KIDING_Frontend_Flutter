import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiding_frontend/core/constants/api_constants.dart';

import 'package:http/http.dart' as http;
import 'package:kiding_frontend/screen/login/back_screen.dart';
import 'package:kiding_frontend/screen/login/find_password_result_screen.dart';

class PasswordResetConfirmScreen extends StatefulWidget {
  final String password;
  final String phone;

  const PasswordResetConfirmScreen(
      {super.key, required this.password, required this.phone});

  @override
  State<PasswordResetConfirmScreen> createState() =>
      _PasswordResetConfirmScreenState();
}

class _PasswordResetConfirmScreenState
    extends State<PasswordResetConfirmScreen> {
  final TextEditingController _pwController =
      TextEditingController(); // 비밀번호 입력 컨트롤러
  String errorMessage = ""; // 에러 메시지
  bool _isErrorVisible = false; // 에러 메시지 앞 동그라미 가시성

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; // 기기 화면 크기
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
              // 안내문
              Image.asset('assets/login/password_confirm_text.png',
                  width: screenSize.width * 0.74,
                  height: screenSize.height * 0.16),
              // 비밀번호 입력칸, 입력 완료 버튼
              Column(
                // 비밀번호 입력 칸
                children: [
                  SizedBox(
                    width: 261.32.w,
                    height: 49.82.h,
                    child: TextField(
                      controller: _pwController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: '비밀번호를 다시 입력하세요',
                          hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                          filled: true,
                          fillColor: Color(0xfff6f6f6),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(100)),
                          contentPadding: EdgeInsets.all(20)),
                      style: TextStyle(
                        fontFamily: 'nanum',
                        fontSize: 17.sp,
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
                        visible: _isErrorVisible,
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
                  // 설정하기 버튼
                  IconButton(
                    onPressed: () {
                      _passwordConfirm();
                    },
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

  // 비밀번호 일치 여부 확인 및 서버로 회원가입 요청
  void _passwordConfirm() async {
    String pwTest = _pwController.text;
    String pw = widget.password;

    if (pwTest != pw) {
      setState(() {
        _isErrorVisible = true;
        errorMessage = "비밀번호가 일치하지 않습니다.";
      });
    } else {
      // 비밀번호가 일치하는 경우 비밀번호 변경 요청
      _resetPassword(pw);
    }
  }

  Future<void> _resetPassword(String pw) async {
    final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.resetPasswordEndpoint}?phoneNumber=${widget.phone}&newPassword=$pw');
    final headers = {'Content-Type': 'application/json'};

    try {
      // 비밀번호 변경 요청
      final response = await http.post(url, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log('Reset Password Response Data: $data');

        if (data['isSuccess']) {
          // 결과 화면으로 이동
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FindPasswordResultScreen()),
          );
        } else {
          log('Reset Password failed: ${data['message']}');
        }
      } else {
        log('Server Error: ${response.statusCode}');
        log('Response Body: ${response.body}');
      }
    } catch (e) {
      log('Error: $e');
    }
  }
}
