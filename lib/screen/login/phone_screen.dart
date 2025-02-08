// 회원가입 전화번호 인증 화면
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kiding_frontend/core/constants/api_constants.dart';
import 'package:kiding_frontend/screen/login/already_exist_screen.dart';
import 'package:kiding_frontend/screen/login/back_screen.dart';
import 'package:kiding_frontend/screen/login/password_screen.dart';

import 'package:http/http.dart' as http;

class PhoneScreen extends StatefulWidget {
  final String nickname;

  const PhoneScreen({super.key, required this.nickname});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final _phoneController = TextEditingController(); // 전화번호 입력 컨트롤러
  final _codeController = TextEditingController(); // 인증 코드 입력 컨트롤러
  String phone = ""; // 전화번호
  bool codeSent = false; // 인증 코드 전송 여부
  bool errorVisible = false; // 에러 발생 여부
  String errorMessage = ""; // 에러 메시지
  late String _verificationId; // 인증 코드

  // Flutter Secure Storage 인스턴스 생성
  final storage = FlutterSecureStorage();

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
              // '전화번호 인증을 진행합니다' 텍스트
              Image.asset('assets/login/phone_greeting_text.png',
                  width: screenSize.width * 0.74,
                  height: screenSize.height * 0.16),
              Column(
                // 전화번호 입력칸 || 인증번호 입력칸
                children: [
                  SizedBox(
                    width: 261.38,
                    height: 50.68,
                    child: TextField(
                      controller: codeSent ? _codeController : _phoneController,
                      decoration: InputDecoration(
                          hintText: codeSent ? '인증번호를 입력하세요' : 'ex.01012345678',
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
                  // 인증번호 전송 여부 메세지
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
                    onPressed: () {
                      if (!codeSent) {
                        _checkPhoneDuplication(_phoneController.text);
                      } else {
                        _sendCode(_codeController.text);
                      }
                    },
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
                  Image.asset('assets/login/progress_colored.png',
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
            errorMessage = "사용 가능한 전화번호입니다.";
          });
          // 중복되지 않은 경우, 인증 코드 전송
          _verifyPhone(phoneNumber);
        } else if (data['result'] == "이미 사용 중인 전화번호입니다.") {
          // 중복된 경우, AlreadyExistScreen으로 전환
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AlreadyExistScreen()),
          );
        } else {
          setState(() {
            errorVisible = true;
            errorMessage = "서버에서 알 수 없는 응답이 반환되었습니다.";
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

  // 전화번호 인증 로직
  Future<void> _verifyPhone(String phoneNumber) async {
    log('인증번호 전송 시도');
    final url = Uri.parse('${ApiConstants.baseUrl}/help/send');
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
    final body = jsonEncode({'phoneNumber': phoneNumber});

    try {
      final response = await http.post(url, headers: headers, body: body);
      final data = jsonDecode(response.body);

      // 서버 응답을 로그로 출력
      log('서버 응답 상태 코드: ${response.statusCode}');
      log('서버 응답 본문: ${response.body}');

      if (data['isSuccess'] == true) {
        setState(() {
          errorVisible = true;
          errorMessage = "인증번호를 보냈습니다.";
          phone = _phoneController.text;
          // 전화번호 입력 칸의 내용을 삭제하고 hintText를 변경
          _phoneController.clear();
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
  Future<void> _sendCode(String code) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/help/send/verify');
    //String? token = await storage.read(key: 'accessToken');

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
    final body = jsonEncode({'code': code});

    try {
      final response = await http.post(url, headers: headers, body: body);
      final data = jsonDecode(response.body);

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
                builder: (context) => PasswordScreen(
                    nickname: widget.nickname, phoneNumber: phone)));
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
