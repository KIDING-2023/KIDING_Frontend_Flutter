// 회원가입 화면
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kiding_frontend/core/constants/api_constants.dart';
import 'package:kiding_frontend/screen/login/back_screen.dart';
import 'package:kiding_frontend/screen/login/phone_screen.dart';

import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nicknameController = TextEditingController(); // 닉네임 입력 컨트롤러
  bool errorVisible = false; // 에러 메시지 가시성
  String errorMessage = ""; // 에러 메시지

  // Flutter Secure Storage 인스턴스 생성
  final storage = FlutterSecureStorage();

  // 금지어 목록
  final List<String> prohibitedWords = [
    "시발",
    "병신",
    "존나",
    "바보",
    "멍청이",
    "윤석열",
    "문재인",
    "박근혜",
    "이명박",
    "마약",
    "개",
    "Fuck",
    "좆",
    "애미",
    "애비",
    "섹스",
    "새끼"
  ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; // 기기 화면 크기
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
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
              // '안녕하세요! 닉네임을 설정해주세요' 텍스트
              Image.asset('assets/login/greeting_text.png',
                  width: screenSize.width * 0.69,
                  height: screenSize.height * 0.15),
              // 닉네임 입력칸, 입력 완료 버튼
              Column(
                // 닉네임 입력칸
                children: [
                  SizedBox(
                    width: screenSize.width * 0.7259,
                    height: screenSize.height * 0.0623,
                    child: TextField(
                      controller: _nicknameController,
                      decoration: InputDecoration(
                          hintText: '닉네임',
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
                  // 닉네임 오류 메시지
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
                  // 입력 완료 버튼
                  IconButton(
                    onPressed: _checkNickname,
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
                  Image.asset('assets/login/progress_colored.png',
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
                  Image.asset('assets/login/progress.png',
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

  // 닉네임 유효성 검사 로직 추가 필요
  Future<void> _checkNickname() async {
    String nickname = _nicknameController.text;

    if (nickname.length > 5) {
      setState(() {
        errorVisible = true;
        errorMessage = "5글자 이하로 입력해주세요.";
      });
    } else if (nickname.isEmpty) {
      setState(() {
        errorVisible = true;
        errorMessage = "닉네임을 입력해주세요.";
      });
    } else if (_containsSpecialCharacter(nickname)) {
      setState(() {
        errorVisible = true;
        errorMessage = "특수문자는 포함할 수 없습니다.";
      });
    } else if (_containsProhibitedWord(nickname)) {
      setState(() {
        errorVisible = true;
        errorMessage = "금지어가 포함되어 있습니다.";
      });
    } else {
      // 닉네임 중복 여부 체크 함수 호출
      await _checkNicknameDuplication(nickname);
    }
  }

  // 금지어 포함 여부 확인
  bool _containsProhibitedWord(String s) {
    return prohibitedWords
        .any((word) => s.toLowerCase().contains(word.toLowerCase()));
  }

  // 특수문자 포함 여부 확인
  bool _containsSpecialCharacter(String s) {
    return RegExp(r'[^A-Za-z0-9가-힣]').hasMatch(s);
  }

  // 닉네임 중복 여부 체크
  Future<void> _checkNicknameDuplication(String nickname) async {
    final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.signupEndpoint}/checkNickname?nickname=$nickname');
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

    try {
      final response = await http.get(url, headers: headers);
      final data = jsonDecode(response.body);

      // 서버 응답을 로그로 출력
      log('서버 응답 상태 코드: ${response.statusCode}');
      log('서버 응답 본문: ${response.body}');

      if (data['isSuccess']) {
        if (data['result'] == "사용 가능한 닉네임입니다.") {
          // 중복되지 않은 경우, 다음 화면으로 이동
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PhoneScreen(nickname: nickname)));
        } else {
          // 중복된 경우, 에러 메시지 표시
          setState(() {
            errorVisible = true;
            errorMessage = "이미 사용 중인 닉네임입니다.";
          });
        }
      } else {
        setState(() {
          errorVisible = true;
          errorMessage = "서버 오류가 발생했습니다.";
        });
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        errorVisible = true;
        errorMessage = "네트워크 오류가 발생했습니다.";
      });
    }
  }
}
