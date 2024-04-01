import 'package:flutter/material.dart';
import 'package:kiding/screen/login/password_screen.dart';

import 'login_splash_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nicknameController = TextEditingController();
  bool _isEclipseVisible = false; // 초기 상태를 false로 설정하여 위젯을 숨깁니다.
  late String _inputErrorText = "";

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

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Stack(
  //       children: <Widget>[
  //         // greeting text
  //         Positioned(
  //             left: 55.61,
  //             top: 99.97,
  //             child: Image.asset(
  //               'assets/login/greeting_text.png',
  //               width: 248.78,
  //               height: 120,
  //             )),
  //         // 닉네임 입력 칸
  //         Positioned(
  //             left: 49.34,
  //             top: 351.64,
  //             child: Container(
  //               width: 261.32,
  //               height: 49.82,
  //               decoration: BoxDecoration(
  //                   image: DecorationImage(
  //                       image: AssetImage('assets/login/nickname_box.png'))),
  //               child: Padding(
  //                 padding: const EdgeInsets.only(left: 26.22),
  //                 child: TextField(
  //                   controller: _nicknameController,
  //                   decoration: InputDecoration(
  //                     hintText: '닉네임을 입력하세요',
  //                     hintStyle: TextStyle(
  //                         fontFamily: 'Nanum',
  //                         fontSize: 17,
  //                         color: Color(0xFFAAAAAA)),
  //                     border: InputBorder.none,
  //                   ),
  //                   style: TextStyle(
  //                     fontFamily: 'Nanum',
  //                     fontSize: 17,
  //                     color: Colors.black,
  //                   ),
  //                 ),
  //               ),
  //             )),
  //         // 오류 메시지 표시
  //         Positioned(
  //             left: 76.46,
  //             top: 413.29,
  //             child: Container(
  //               width: 195.23,
  //               height: 14.11,
  //               child: Row(
  //                 children: [
  //                   Visibility(
  //                     visible: _isEclipseVisible,
  //                     child: Image.asset('assets/login/eclipse.png',
  //                         width: 2.63, height: 2.63),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(left: 5),
  //                     child: Text(
  //                       _inputErrorText ?? '',
  //                       style: TextStyle(
  //                         fontSize: 13,
  //                         fontFamily: 'Nanum',
  //                         color: Color(0xFFFFa37C)
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             )),
  //         // 시작하기 버튼
  //         Positioned(
  //           left: 49.34,
  //           top: 437.25,
  //           child: GestureDetector(
  //             onTap: _signup,
  //             child: Container(
  //               width: 261.32,
  //               height: 49.82,
  //               decoration: BoxDecoration(
  //                   image: DecorationImage(
  //                       image: AssetImage('assets/login/join_btn.png'))),
  //               child: Center(
  //                 child: Text(
  //                   '시작하기',
  //                   style: TextStyle(
  //                     fontSize: 17,
  //                     fontFamily: 'Nanum',
  //                     color: Colors.white,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Center( // This widget is positioned at the top of the Column
              child: Image.asset(
                'assets/login/greeting_text.png',
                width: 248.78,
                height: 120.0,
              ),
            ),
          ),
          Positioned(
            top: 351.64,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,// Takes up as little space as possible
              children: <Widget>[
                Container(
                  width: 261.32,
                  height: 49.82,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.91),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x26000000),
                        blurRadius: 1.75,
                        offset: Offset(0, 0.87),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: _nicknameController,
                    decoration: InputDecoration(
                      hintText: '닉네임을 입력하세요',
                      hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 26.22),
                    ),
                    style: TextStyle(
                      fontFamily: 'Nanum',
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 17.08),
                Container(
                  width: 195.23,
                  height: 14.11,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Visibility(
                        visible: _isEclipseVisible,
                        child: Image.asset('assets/login/eclipse.png'),
                      ),
                      SizedBox(width: 4.82),
                      Text(
                        _inputErrorText ?? '',
                        style: TextStyle(
                          fontFamily: 'Nanum',
                          fontSize: 13,
                          color: Color(0xFFFFA37C),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 9.85),
                ElevatedButton(
                  onPressed: _signup,
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFFF6A2B),
                    minimumSize: Size(261.32, 49.82),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text(
                    '시작하기',
                    style: TextStyle(
                      fontFamily: 'Nanum',
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  void _signup() {
    String nickname = _nicknameController.text;
    // 닉네임 유효성 검사 로직

    if (nickname.isEmpty) {
      setState(() {
        _isEclipseVisible = true;
        _inputErrorText = "닉네임을 입력해주세요";
      });
    } else if (nickname.length > 5) {
      setState(() {
        _isEclipseVisible = true;
        _inputErrorText = "5글자 이하로 입력해주세요";
      });
    } else if (_containsSpecialCharacter(nickname)) {
      setState(() {
        _isEclipseVisible = true;
        _inputErrorText = "특수문자는 포함할 수 없습니다";
      });
    } else if (_containsProhibitedWord(nickname)) {
      setState(() {
        _isEclipseVisible = true;
        _inputErrorText = "금지어가 포함되어 있습니다";
      });
    } else {
      //_doSignup(nickname);
      // 회원가입 성공 처리
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PasswordScreen(
                  nickname: nickname,
                )),
      );
    }
  }

  bool _containsProhibitedWord(String s) {
    return prohibitedWords
        .any((word) => s.toLowerCase().contains(word.toLowerCase()));
  }

  bool _containsSpecialCharacter(String s) {
    return RegExp(r'[^A-Za-z0-9가-힣]').hasMatch(s);
  }

  // Future<void> _doSignup(String nickname) async {
  //   // 서버에 회원가입 요청을 보내고 응답을 처리하는 로직을 구현합니다.
  //   // 예시 URL과 요청 본문은 실제 API에 맞게 수정해야 합니다.
  //   var response = await http.post(
  //     Uri.parse('https://yourapi/signup'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: json.encode({'nickname': nickname}),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     var result = json.decode(response.body);
  //     if (result['isSuccess']) {
  //       // 회원가입 성공 처리
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => SuccessScreen(nickname)),
  //       );
  //     } else {
  //       // 이미 존재하는 닉네임 오류 처리
  //       setState(() {
  //         _inputErrorText = "이미 존재하는 닉네임입니다.";
  //       });
  //     }
  //   } else {
  //     // 오류 처리
  //     setState(() {
  //       _inputErrorText = "회원가입 실패";
  //     });
  //   }
  // }
}
