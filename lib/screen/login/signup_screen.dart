import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiding/screen/login/back_screen.dart';
import 'package:kiding/screen/login/phone_screen.dart';
import 'package:http/http.dart' as http;

// 회원가입 화면
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nicknameController = TextEditingController(); // 닉네임 입력 컨트롤러
  bool errorVisible = false; // 에러 메시지 가시성
  String errorMessage = ""; // 에러 메시지

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
                  Container(
                    width: screenSize.width * 0.73,
                    height: screenSize.height * 0.06,
                    // 텍스트 박스 하단 그림자
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff000000).withOpacity(0.15),
                            spreadRadius: 0,
                            blurRadius: 1.75,
                            offset:
                                Offset(0, 0.87), // changes position of shadow
                          )
                        ]),
                    child: TextField(
                      controller: _nicknameController,
                      decoration: InputDecoration(
                          hintText: '닉네임',
                          hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(100)),
                          contentPadding: EdgeInsets.only(left: 20)),
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
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PhoneScreen(nickname: nickname)));
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
}
