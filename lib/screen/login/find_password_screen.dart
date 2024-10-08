import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kiding/screen/login/password_phone_screen.dart';
import 'package:kiding/screen/login/start_screen.dart';

// 비밀번호 찾기 - 전화번호 입력 화면
class FindPasswordScreen extends StatefulWidget {
  const FindPasswordScreen({super.key});

  @override
  State<FindPasswordScreen> createState() => _FindPasswordScreenState();
}

class _FindPasswordScreenState extends State<FindPasswordScreen> {
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
              // '비밀번호 찾기' 텍스트
              Image.asset('assets/login/find_password_text.png',
                  width: screenSize.width * 0.74,
                  height: screenSize.height * 0.11),
              // 전화번호 입력칸, 비밀번호 찾기 버튼
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
                          enabledBorder: OutlineInputBorder(
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
                  // 비밀번호 찾기 버튼
                  IconButton(
                    onPressed: _findPassword,
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

  void _findPassword() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PasswordPhoneScreen(
                phone: _phoneController.text.replaceFirst('0', '+82'))));
  }
}
