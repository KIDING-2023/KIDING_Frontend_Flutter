// 비밀번호 찾기 - 전화번호 인증 코드 입력 화면
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kiding_frontend/core/constants/api_constants.dart';
import 'package:kiding_frontend/screen/login/password_reset_screen.dart';
import 'package:kiding_frontend/screen/login/start_screen.dart';

import 'package:http/http.dart' as http;

class PasswordPhoneScreen extends StatefulWidget {
  final String phone; // 전화번호 받아오기

  const PasswordPhoneScreen({super.key, required this.phone});

  @override
  State<PasswordPhoneScreen> createState() => _PasswordPhoneScreenState();
}

class _PasswordPhoneScreenState extends State<PasswordPhoneScreen> {
  final _codeController = TextEditingController(); // 인증코드 입력 컨트롤러
  bool errorVisible = false; // 에러 메시지 가시성
  String errorMessage = ""; // 에러 메시지
  bool codeSent = false; // 인증 코드 전송 여부
  late String _verificationId; // 인증 코드

  @override
  void initState() {
    super.initState();
    _verifyPhone(widget.phone); // 화면 로드 시 인증번호 전송 함수 실행
  }

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
              // '전화번호 인증을 진행합니다' 텍스트
              Image.asset('assets/login/phone_greeting_text.png',
                  width: screenSize.width * 0.74,
                  height: screenSize.height * 0.16),
              // 인증번호 입력칸, 비밀번호 찾기 버튼
              Column(
                // 인증번호 입력 칸
                children: [
                  SizedBox(
                    width: screenSize.width * 0.73,
                    height: screenSize.height * 0.06,
                    child: TextField(
                      controller: _codeController,
                      decoration: InputDecoration(
                          hintText: '인증번호를 입력하세요',
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
                  // 인증번호 오류 메시지
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
                            fontSize: 13,
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
                      if (codeSent) {
                        _verifyCode(_codeController.text);
                      }
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

  // 전화번호 인증 로직
  Future<void> _verifyPhone(String phoneNumber) async {
    log('인증번호 전송 시도');
    final url = Uri.parse('${ApiConstants.baseUrl}/help/send');

    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({'phoneNumber': phoneNumber});

    try {
      final response = await http.post(url, headers: headers, body: body);
      log('인증번호 전송 시도');
      final data = jsonDecode(response.body);

      // 서버 응답을 로그로 출력
      log('서버 응답 상태 코드: ${response.statusCode}');
      log('서버 응답 본문: ${response.body}');

      if (data['isSuccess'] == true) {
        setState(() {
          errorVisible = true;
          errorMessage = "인증번호를 보냈습니다.";
          codeSent = true; // 인증번호 입력 모드로 전환
        });
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

  // 인증번호 검증 로직
  Future<void> _verifyCode(String code) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/help/send/verify');

    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({'code': code});

    try {
      final response = await http.post(url, headers: headers, body: body);

      // 서버 응답을 로그로 출력
      log('서버 응답 상태 코드: ${response.statusCode}');
      log('서버 응답 본문: ${response.body}');

      if (response.statusCode == 200) {
        setState(() {
          errorVisible = true;
          errorMessage = "정상 인증 되었습니다.";
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PasswordResetScreen(phone: widget.phone)));
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
}
