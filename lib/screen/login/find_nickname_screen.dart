import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'nickname_phone_screen.dart';

class FindNicknameScreen extends StatefulWidget {
  const FindNicknameScreen({super.key});

  @override
  State<FindNicknameScreen> createState() => _FindNicknameScreenState();
}

class _FindNicknameScreenState extends State<FindNicknameScreen> {
  final _phoneController = TextEditingController();
  bool errorVisible = false;
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // 안내문
          Image.asset('assets/login/find_nickname_text.png',
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
              // 닉네임 찾기 버튼
              IconButton(
                onPressed: _findNickname,
                padding: EdgeInsets.zero,
                icon: Image.asset('assets/login/find_nickname_btn.png',
                    width: screenSize.width * 0.7),
              ),
            ],
          ),
        ],
      )
    );
  }

  void _findNickname() async {
    final DatabaseReference dbRef = FirebaseDatabase.instance.ref('users');
    final String phone = _phoneController.text;

    DataSnapshot snapshot = await dbRef.child(phone).get();

    if (snapshot.exists && snapshot.value != null) {
      try {
        // snapshot.value를 안전하게 Map으로 변환
        Map<dynamic, dynamic> userData =
            snapshot.value as Map<dynamic, dynamic>;
        String nickname = userData['nickname'] as String; // 닉네임 추출
        setState(() {
          errorVisible = false;
          errorMessage = '';
        });
        print('찾은 닉네임: $nickname');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NicknamePhoneScreen(
                    nickname: nickname,
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
