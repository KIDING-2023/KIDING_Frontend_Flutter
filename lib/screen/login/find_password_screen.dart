// 비밀번호 찾기 - 전화번호 입력 화면
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiding_frontend/core/constants/api_constants.dart';
import 'package:kiding_frontend/screen/login/password_phone_screen.dart';
import 'package:kiding_frontend/screen/login/start_screen.dart';

import 'package:http/http.dart' as http;

class FindPasswordScreen extends StatefulWidget {
  const FindPasswordScreen({super.key});

  @override
  State<FindPasswordScreen> createState() => _FindPasswordScreenState();
}

class _FindPasswordScreenState extends State<FindPasswordScreen> {
  final _phoneController = TextEditingController(); // 전화번호 입력 컨트롤러
  bool errorVisible = true; // 에러 메시지 가시성
  bool isValid = false; // 존재하는 유저인지
  String errorMessage = "전화번호를 입력하세요"; // 에러 메시지

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
                    MaterialPageRoute(builder: (context) => StartScreen()));
              },
              icon: Image.asset('assets/kikisday/back_icon.png',
                  width: screenSize.width * 0.04,
                  height: screenSize.height * 0.03),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // '비밀번호 찾기' 텍스트
              Image.asset('assets/login/find_password_text.png',
                  width: screenSize.width * 0.74,
                  height: screenSize.height * 0.11),
              // 전화번호 입력칸, 비밀번호 찾기 버튼
              Column(
                // 전화번호 입력칸
                children: [
                  SizedBox(
                    width: 261.32.w,
                    height: 49.82.h,
                    child: TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                          hintText: 'ex) 01012345678',
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
                  // 전화번호 오류 메시지
                  Row(
                    children: [
                      Padding(
                          padding:
                              EdgeInsets.only(left: screenSize.width * 0.21)),
                      Visibility(
                        visible: errorVisible,
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
                  // 비밀번호 찾기 버튼
                  IconButton(
                    onPressed: () {
                      _checkPhoneDuplication(_phoneController.text);
                    },
                    padding: EdgeInsets.zero,
                    icon: Image.asset('assets/login/find_password_btn.png',
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

  // 전화번호 중복 여부 체크
  Future<void> _checkPhoneDuplication(String phoneNumber) async {
    log('phone: $phoneNumber');
    final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.signupEndpoint}/checkPhone?phone=$phoneNumber');

    final headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);
      final data = jsonDecode(response.body);

      // 서버 응답을 로그로 출력
      log('서버 응답 상태 코드: ${response.statusCode}');
      log('서버 응답 본문: ${response.body}');

      if (data['isSuccess']) {
        if (data['result'] == "사용 가능한 전화번호입니다.") {
          setState(() {
            errorVisible = true;
            errorMessage = "가입되지 않은 전화번호입니다.";
            isValid = false;
          });
        } else {
          // 데이터베이스에 존재하는 전화번호일 경우
          setState(() {
            errorVisible = false;
            isValid = true;
          });
          _findPassword();
        }
      } else {
        setState(() {
          errorVisible = true;
          errorMessage = "서버 오류가 발생했습니다.";
        });
      }
    } catch (e) {
      setState(() {
        errorVisible = true;
        errorMessage = "네트워크 오류가 발생했습니다.";
      });
    }
  }

  void _findPassword() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PasswordPhoneScreen(phone: _phoneController.text)));
  }
}
