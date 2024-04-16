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
    return Scaffold(
      body: Stack(
        children: [
          // 닉네임 찾기 안내문
          Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Image.asset('assets/login/find_nickname_text.png',
                  width: 267.47, height: 88)),
          // 전화번호 입력칸
          Positioned(
              top: 350.74,
              left: 0,
              right: 0,
              child: Image.asset('assets/login/nickname_box.png',
                  width: 262, height: 50)),
          Positioned(
              top: 351,
              left: 78,
              right: 0,
              child: TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                    hintText: '전화번호를 입력하세요',
                    hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                    border: InputBorder.none),
                style: TextStyle(
                    fontFamily: 'nanum', fontSize: 17, color: Colors.black),
              )),
          // 전화번호 에러 표시
          Positioned(
              top: 412.29,
              left: 76.95,
              child: Row(
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
              )),
          // 닉네임 찾기 버튼
          Positioned(
              top: 437.95,
              left: 0,
              right: 0,
              child: IconButton(
                onPressed: _findNickname,
                padding: EdgeInsets.zero,
                icon: Image.asset('assets/login/find_nickname_btn.png',
                    width: 261.32, height: 49.82),
              )),
        ],
      ),
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
