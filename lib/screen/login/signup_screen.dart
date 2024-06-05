import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiding/screen/login/phone_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nicknameController = TextEditingController();
  bool errorVisible = false;
  String errorMessage = "";

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
    "Fuck"
  ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // 안내문
        Image.asset('assets/login/greeting_text.png',
            width: 248.78, height: 120),
        Column(
          // 닉네임 입력 칸
          children: [
            Container(
              width: screenSize.width * 0.7,
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
              height: 5,
            ),
            // 닉네임 오류 메시지
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: errorVisible,
                  child: Icon(
                    Icons.circle,
                    size: 2.63,
                    fill: 1.0,
                    color: Color(0xFFFFA37C),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 5.0)),
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
              height: 5,
            ),
            // 입력 완료 버튼
            IconButton(
              onPressed: _checkNickname,
              padding: EdgeInsets.zero,
              icon: Image.asset('assets/login/input_finish_btn.png',
                  width: screenSize.width * 0.7),
            ),
          ],
        ),
        // 진행 표시 선
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/login/progress_colored.png',
                width: 82.76, height: 4.5),
            SizedBox(
              width: 5,
            ),
            Image.asset('assets/login/progress.png', width: 82.76, height: 4.5),
            SizedBox(
              width: 5,
            ),
            Image.asset('assets/login/progress.png', width: 82.76, height: 4.5),
          ],
        )
      ],
    ));
  }

  // 닉네임 오류 체크
  void _checkNickname() {
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

  // 금지어가 있는 지 확인
  bool _containsProhibitedWord(String s) {
    return prohibitedWords
        .any((word) => s.toLowerCase().contains(word.toLowerCase()));
  }

  // 특수문자가 있는 지 확인
  bool _containsSpecialCharacter(String s) {
    return RegExp(r'[^A-Za-z0-9가-힣]').hasMatch(s);
  }
}
