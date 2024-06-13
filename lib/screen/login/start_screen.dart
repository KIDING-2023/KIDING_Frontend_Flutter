import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kiding/screen/home/home_screen.dart';
import 'package:kiding/screen/login/login_splash_screen.dart';
import 'package:kiding/screen/login/signup_screen.dart';
import 'package:mysql1/mysql1.dart';

import 'find_nickname_screen.dart';
import 'find_password_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final _nicknameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isErrorVisible = false;
  bool _isStayLoggedIn = false;  // 로그인 상태 유지
  final _storage = FlutterSecureStorage();  // Secure storage 객체 생성


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // 인삿말
          Image.asset('assets/login/start_greeting_text.png',
              width: 248.78, height: 81.09),
          // 닉네임 입력칸
          Column(
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
                height: 10,
              ),
              // 비밀번호 입력칸
              Container(
                width: screenSize.width * 0.7,
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
              SizedBox(
                height: 10,
              ),
              // 로그인 상태 유지 버튼
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
              // 시작하기 버튼
              Container(
                width: screenSize.width * 0.7,
                child: IconButton(
                  onPressed: _login,
                  padding: EdgeInsets.zero,
                  icon: Image.asset('assets/login/start_btn.png'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // 에러 메세지
              Container(
                  child: _isErrorVisible
                      ? Image.asset('assets/login/start_error_text.png',
                      width: 187.54, height: 36)
                      : SizedBox()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 회원가입 버튼
              Container(
                width: 69,
                height: 13,
                child: IconButton(
                  onPressed: _signup,
                  padding: EdgeInsets.zero,
                  icon: Image.asset('assets/login/to_signup_btn.png'),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Image.asset('assets/login/vertical_line.png',
                  width: 1.5, height: 14),
              SizedBox(
                width: 5,
              ),
              // 닉네임 찾기 버튼
              Container(
                width: 57,
                height: 13,
                child: IconButton(
                  onPressed: _findNickname,
                  padding: EdgeInsets.zero,
                  icon: Image.asset('assets/login/to_find_nickname_btn.png'),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Image.asset('assets/login/vertical_line.png',
                  width: 1.5, height: 14),
              SizedBox(
                width: 5,
              ),
              // 비밀번호 찾기 버튼
              Container(
                width: 72,
                height: 13,
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
    ));
  }

  void _toggleLoginState() {
    setState(() {
      _isStayLoggedIn = !_isStayLoggedIn; // 상태 토글
    });
  }

  // 닉네임과 비밀번호를 검증하는 로직 추가
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
