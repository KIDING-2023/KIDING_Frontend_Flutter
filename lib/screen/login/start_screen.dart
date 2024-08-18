import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kiding/screen/home/home_screen.dart';
import 'package:kiding/screen/login/signup_screen.dart';

import 'find_nickname_screen.dart';
import 'find_password_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final _nicknameController = TextEditingController();  // 닉네임 컨트롤러
  final _passwordController = TextEditingController();  // 비밀번호 컨트롤러
  bool _isErrorVisible = false;  // 로그인 에러 발생 체크
  bool _isStayLoggedIn = false;  // 로그인 상태 유지 체크
  final _storage = FlutterSecureStorage();  // Secure storage 객체 생성


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;  // 기기의 화면 크기
    return Scaffold(
        body: Center(  // 중앙 정렬
      child: Container(
        color: Colors.white,  // 배경색: white
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,  // 동일한 간격으로 위젯 배치
          children: [
            // '환영합니다! 키딩북' 텍스트
            Image.asset('assets/login/start_greeting_text.png',
                width: screenSize.width * 0.69, height: screenSize.height * 0.1),
            // 닉네임 입력칸
            Column(
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
                        offset: Offset(0, 0.87), // changes position of shadow
                      )
                    ]
                  ),
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
                // 닉네임 입력칸과 비밀번호 입력칸 사이의 공백
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                // 비밀번호 입력칸
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
                          offset: Offset(0, 0.87), // changes position of shadow
                        )
                      ]
                  ),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: '비밀번호',
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
                // 비밀번호 입력칸과 시작하기 버튼 사이의 여백
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                // 시작하기 버튼
                Container(
                  width: screenSize.width * 0.73,
                  child: IconButton(
                    onPressed: _login,
                    padding: EdgeInsets.zero,
                    icon: Image.asset('assets/login/start_btn.png'),
                  ),
                ),
                // 시작하기 버튼과 로그인 유지 버튼 사이의 여백
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                // 로그인 상태 유지 버튼
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: _toggleLoginState,
                      child: Image.asset(
                        _isStayLoggedIn
                            ? 'assets/login/keep_login_selected_btn.png' // 로그인 상태 유지 활성화 이미지
                            : 'assets/login/keep_login_btn.png', // 로그인 상태 유지 비활성화 이미지
                        width: 75,
                        height: 18,
                      ),
                    ),
                    // 체크박스와 '로그인 유지' 텍스트 사이의 여백
                    SizedBox(
                      width: screenSize.width * 0.02,
                    )
                  ],
                ),
                // 로그인 유지 버튼과 에러 메시지 사이의 여백
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                // 에러 메세지
                Container(
                    child: _isErrorVisible
                        ? Image.asset('assets/login/start_error_text.png',
                        width: screenSize.width * 0.52, height: screenSize.height * 0.05)
                        : SizedBox()),
              ],
            ),
            // 회원가입하기 | 닉네임 찾기 | 비밀번호 찾기
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 회원가입 버튼
                Container(
                  width: screenSize.width * 0.19,
                  height: screenSize.height * 0.02,
                  child: IconButton(
                    onPressed: _signup,
                    padding: EdgeInsets.zero,
                    icon: Image.asset('assets/login/to_signup_btn.png'),
                  ),
                ),
                SizedBox(
                  width: screenSize.width * 0.01,
                ),
                // 구분선
                Image.asset('assets/login/vertical_line.png',
                    width: screenSize.width * 0.01, height: screenSize.height * 0.02),
                SizedBox(
                  width: screenSize.width * 0.01,
                ),
                // 닉네임 찾기 버튼
                Container(
                  width: screenSize.width * 0.16,
                  height: screenSize.height * 0.02,
                  child: IconButton(
                    onPressed: _findNickname,
                    padding: EdgeInsets.zero,
                    icon: Image.asset('assets/login/to_find_nickname_btn.png'),
                  ),
                ),
                SizedBox(
                  width: screenSize.width * 0.01,
                ),
                // 구분선
                Image.asset('assets/login/vertical_line.png',
                    width: screenSize.width * 0.01, height: screenSize.height * 0.02),
                SizedBox(
                  width: screenSize.width * 0.01,
                ),
                // 비밀번호 찾기 버튼
                Container(
                  width: screenSize.width * 0.2,
                  height: screenSize.height * 0.02,
                  child: IconButton(
                    onPressed: _findPassword,
                    padding: EdgeInsets.zero,
                    icon: Image.asset('assets/login/to_find_password_btn.png'),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }

  // 로그인 유지 버튼 토글
  void _toggleLoginState() {
    setState(() {
      _isStayLoggedIn = !_isStayLoggedIn; // 상태 토글
    });
  }

  // 닉네임, 비밀번호 검증 로직 추가 필요
  Future<void> _login() async {
    String nickname = _nicknameController.text.trim();
    String password = _passwordController.text.trim();

    if (nickname == "전시원" && password == "5236cool") {
      if (_isStayLoggedIn) {
        await _storage.write(key: 'isLoggedIn', value: 'true');
        await _storage.write(key: 'nickname', value: nickname);
      } else {
        await _storage.delete(key: 'isLoggedIn');
        await _storage.delete(key: 'nickname');
      }
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      setState(() {
        _isErrorVisible = true;
      });
    }
  }

  // 로그인 유지 여부 확인
  Future<void> checkLoginStatus() async {
    String? isLoggedIn = await _storage.read(key: 'isLoggedIn');
    if (isLoggedIn != null && isLoggedIn == 'true') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  // 회원가입 화면으로 이동
  void _signup() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignupScreen()));
  }

  // 닉네임 찾기 화면으로 이동
  void _findNickname() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FindNicknameScreen()));
  }

  // 비밀번호 찾기 화면으로 이동
  void _findPassword() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FindPasswordScreen()));
  }
}
