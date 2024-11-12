import 'dart:convert';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kiding/screen/login/find_nickname_result_screen.dart';
import 'package:kiding/screen/login/start_screen.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/api_constants.dart';

// 닉네임 찾기 - 전화번호 입력 화면
class FindNicknameScreen extends StatefulWidget {
  const FindNicknameScreen({super.key});

  @override
  State<FindNicknameScreen> createState() => _FindNicknameScreenState();
}

class _FindNicknameScreenState extends State<FindNicknameScreen> {
  final _phoneController = TextEditingController(); // 전화번호 입력 컨트롤러
  bool errorVisible = false; // 에러 메시지 가시성
  String errorMessage = ""; // 에러 메시지

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
                  Container(
                    width: screenSize.width * 0.73,
                    height: screenSize.height * 0.06,
                    child: TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                          hintText: '전화번호를 입력하세요',
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

  // // 닉네임 찾기 로직 추가 필요
  // void _findNickname() async {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => FindNicknameResultScreen(nickname: '닉네임')));
  // }

  String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 11) {
      // "01111111111" -> "011-1111-1111"
      return '${phoneNumber.substring(0, 3)}-${phoneNumber.substring(3, 7)}-${phoneNumber.substring(7)}';
    } else if (phoneNumber.length == 10) {
      // "0211111111" -> "02-1111-1111"
      return '${phoneNumber.substring(0, 2)}-${phoneNumber.substring(2, 6)}-${phoneNumber.substring(6)}';
    } else {
      // 형식에 맞지 않는 경우 그대로 반환
      return phoneNumber;
    }
  }

  // 전화번호 인증 로직
  Future<void> _findNickname(String phoneNumber) async {
    String phone = formatPhoneNumber(phoneNumber);
    log('닉네임 찾기 시도');
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.findNicknameEndpoint}?phone=$phone');
    // String? token = await storage.read(key: 'accessToken');

    // if (token == null) {
    //   setState(() {
    //     errorVisible = true;
    //     errorMessage = "인증 오류가 발생했습니다. 다시 시도해주세요.";
    //   });
    //   return;
    // }

    final headers = {
      //'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    //final body = jsonEncode({'phoneNumber': phoneNumber});

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
                    builder: (context) => FindNicknameResultScreen(nickname: data['result'])));
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
