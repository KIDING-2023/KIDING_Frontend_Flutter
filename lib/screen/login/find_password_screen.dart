import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kiding/screen/login/password_phone_screen.dart';

class FindPasswordScreen extends StatefulWidget {
  const FindPasswordScreen({super.key});

  @override
  State<FindPasswordScreen> createState() => _FindPasswordScreenState();
}

class _FindPasswordScreenState extends State<FindPasswordScreen> {
  final _phoneController = TextEditingController();
  bool errorVisible = false;
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // 뒤로가기 버튼
          Positioned(
            top: 30.0,
            left: 30.0,
            child: Padding(
              padding: const EdgeInsets.only(top: 15),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset('assets/kikisday/back_icon.png',
                    width: 13.16, height: 20.0),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 안내문
              Image.asset('assets/login/find_password_text.png',
                  width: 267.47, height: 88),
              Column(
                // 전화번호 입력 칸
                children: [
                  Container(
                    width: screenSize.width * 0.7,
                    child: TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                          hintText: '전화번호를 입력하세요',
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
                  // 전화번호 오류 메시지
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 70.0)),
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
                  // 비밀번호 찾기 버튼
                  IconButton(
                    onPressed: _findPassword,
                    padding: EdgeInsets.zero,
                    icon: Image.asset('assets/login/find_password_btn.png',
                        width: screenSize.width * 0.7),
                  ),
                ],
              ),
            ],
          ),
        ],
      )
    );
  }

  void _findPassword() async {
    final DatabaseReference dbRef = FirebaseDatabase.instance.ref('users');
    final String phone = _phoneController.text;

    DataSnapshot snapshot = await dbRef.child(phone).get();

    if (snapshot.exists && snapshot.value != null) {
      try {
        // snapshot.value를 안전하게 Map으로 변환
        Map<dynamic, dynamic> userData =
        snapshot.value as Map<dynamic, dynamic>;
        String password = userData['password'] as String; // 닉네임 추출
        setState(() {
          errorVisible = false;
          errorMessage = '';
        });
        print('찾은 비밀번호: $password');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PasswordPhoneScreen(
                    password: password,
                    phone: _phoneController.text.replaceFirst('0', '+82'))));
      } catch (e) {
        // 타입 변환 실패 시
        print('Data type conversion error: $e');
        setState(() {
          errorVisible = true;
          errorMessage = '데이터 형식 오류';
        });
      }
    } else {
      setState(() {
        errorVisible = true;
        errorMessage = '없는 전화번호입니다.';
      });
    }
  }
}
