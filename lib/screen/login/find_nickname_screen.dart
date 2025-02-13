// 닉네임 찾기 - 전화번호 입력 화면
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiding_frontend/core/constants/api_constants.dart';
import 'package:kiding_frontend/screen/login/find_nickname_result_screen.dart';
import 'package:kiding_frontend/screen/login/start_screen.dart';

import 'package:http/http.dart' as http;

class FindNicknameScreen extends StatefulWidget {
  const FindNicknameScreen({super.key});

  @override
  State<FindNicknameScreen> createState() => _FindNicknameScreenState();
}

class _FindNicknameScreenState extends State<FindNicknameScreen> {
  final _phoneController = TextEditingController(); // 전화번호 입력 컨트롤러
  bool errorVisible = true; // 에러 메시지 가시성
  String errorMessage = "전화번호를 입력하세요."; // 에러 메시지

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
              // '닉네임 찾기' 텍스트
              Image.asset('assets/login/find_nickname_text.png',
                  width: screenSize.width * 0.74,
                  height: screenSize.height * 0.11),
              // 전화번호 입력칸, 닉네임 찾기 버튼
              Column(
                // 전화번호 입력칸
                children: [
                  SizedBox(
                    width: 261.32.w,
                    height: 49.82.h,
                    child: TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                          hintText: 'ex.01012345678',
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
                            fontSize: 13,
                            color: Color(0xFFFFA37C)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  // 닉네임 찾기 버튼
                  IconButton(
                    onPressed: () {
                      _findNickname(_phoneController.text);
                    },
                    padding: EdgeInsets.zero,
                    icon: Image.asset('assets/login/find_nickname_btn.png',
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
  Future<void> _findNickname(String phoneNumber) async {
    log('닉네임 찾기 시도');
    final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.findNicknameEndpoint}?phone=$phoneNumber');
    final headers = {
      //'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);
      log('닉네임 찾기 시도');
      final data = jsonDecode(response.body);

      // 서버 응답을 로그로 출력
      log('서버 응답 상태 코드: ${response.statusCode}');
      log('서버 응답 본문: ${response.body}');

      if (data['isSuccess'] == true) {
        if (data['result'] == "사용자를 찾을 수 없습니다.") {
          setState(() {
            errorVisible = true;
            errorMessage = "사용자를 찾을 수 없습니다.";
          });
        } else {
          setState(() {
            errorVisible = true;
            errorMessage = "닉네임을 찾았습니다.";
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        FindNicknameResultScreen(nickname: data['result'])));
          });
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
}
