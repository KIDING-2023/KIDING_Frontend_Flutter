// 캐릭터 선택 화면
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kiding_frontend/core/constants/api_constants.dart';

import 'package:http/http.dart' as http;
import 'package:kiding_frontend/screen/login/terms_screen.dart';

class ChooseCharacterScreen extends StatefulWidget {
  final String nickname; // 닉네임 받아오기

  const ChooseCharacterScreen({super.key, required this.nickname});

  @override
  ChooseCharacterScreenState createState() => ChooseCharacterScreenState();
}

class ChooseCharacterScreenState extends State<ChooseCharacterScreen> {
  int _selectedCharacterIndex = -1;
  final storage = FlutterSecureStorage(); // Secure Storage 인스턴스

  List<String> characterImages = [
    'assets/login/character1.png',
    'assets/login/character2.png',
    'assets/login/character3.png',
    'assets/login/character4.png',
  ];

  // 선택된 캐릭터에 따른 캐릭터 이미지 리스트
  List<String> _characterList(int index) {
    List<String> characterList;
    switch (index) {
      case 1:
        characterList = [
          'assets/login/character1_selected.png',
          'assets/login/character2.png',
          'assets/login/character3.png',
          'assets/login/character4.png',
        ];
        break;
      case 2:
        characterList = [
          'assets/login/character1.png',
          'assets/login/character2_selected.png',
          'assets/login/character3.png',
          'assets/login/character4.png',
        ];
        break;
      case 3:
        characterList = [
          'assets/login/character1.png',
          'assets/login/character2.png',
          'assets/login/character3_selected.png',
          'assets/login/character4.png',
        ];
        break;
      case 4:
        characterList = [
          'assets/login/character1.png',
          'assets/login/character2.png',
          'assets/login/character3.png',
          'assets/login/character4_selected.png',
        ];
        break;
      default:
        characterList = [
          'assets/login/character1.png',
          'assets/login/character2.png',
          'assets/login/character3.png',
          'assets/login/character4.png',
        ];
        break;
    }
    return characterList;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; // 기기 화면 크기
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Stack(
        children: [
          // '캐릭터를 선택해주세요' 텍스트
          Positioned(
            top: screenSize.height * 0.12,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                '안녕하세요 ${widget.nickname}님,\n캐릭터를 선택해주세요',
                style: TextStyle(
                  fontFamily: 'Nanum',
                  fontSize: 23.sp,
                  color: Colors.black,
                  height: 1.77.h,
                ),
              ),
            ),
          ),
          // 키딩북 로고
          Positioned(
            top: screenSize.height * 0.27,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/login/character_logo.png',
              width: screenSize.width * 0.69,
              height: screenSize.height * 0.04,
            ),
          ),
          // 1번 캐릭터
          Positioned(
            top: screenSize.height * 0.34,
            left: screenSize.width * 0.13,
            child: IconButton(
              onPressed: () {
                setState(() {
                  _selectedCharacterIndex = 1;
                });
              },
              icon: Image.asset(
                _characterList(_selectedCharacterIndex)[0],
                width: screenSize.width * 0.32,
                height: screenSize.height * 0.14,
              ),
            ),
          ),
          // 2번 캐릭터
          Positioned(
            top: screenSize.height * 0.34,
            right: screenSize.width * 0.13,
            child: IconButton(
              onPressed: () {
                setState(() {
                  _selectedCharacterIndex = 2;
                });
              },
              icon: Image.asset(
                _characterList(_selectedCharacterIndex)[1],
                width: screenSize.width * 0.32,
                height: screenSize.height * 0.14,
              ),
            ),
          ),
          // 3번 캐릭터
          Positioned(
            top: screenSize.height * 0.51,
            left: screenSize.width * 0.13,
            child: IconButton(
              onPressed: () {
                setState(() {
                  _selectedCharacterIndex = 3;
                });
              },
              icon: Image.asset(
                _characterList(_selectedCharacterIndex)[2],
                width: screenSize.width * 0.32,
                height: screenSize.height * 0.14,
              ),
            ),
          ),
          // 4번 캐릭터
          Positioned(
            top: screenSize.height * 0.51,
            right: screenSize.width * 0.13,
            child: IconButton(
              onPressed: () {
                setState(() {
                  _selectedCharacterIndex = 4;
                });
              },
              icon: Image.asset(
                _characterList(_selectedCharacterIndex)[3],
                width: screenSize.width * 0.32,
                height: screenSize.height * 0.14,
              ),
            ),
          ),
          // 시작하기 버튼
          Positioned(
            top: screenSize.height * 0.86,
            left: 0,
            right: 0,
            child: Visibility(
              visible: _selectedCharacterIndex != -1,
              child: GestureDetector(
                onTap: () async {
                  await _setCharacter(_selectedCharacterIndex);
                },
                child: Image.asset('assets/login/character_start_btn.png',
                    width: screenSize.width * 0.87,
                    height: screenSize.height * 0.06),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  // 서버로 캐릭터 선택 정보 전송
  Future<void> _setCharacter(int num) async {
    String? token = await storage.read(key: 'accessToken');

    // 서버 URL에 선택한 캐릭터 값 포함
    var url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.characterEndpoint}/$num');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // 토큰을 인증 헤더에 추가
    };

    try {
      var response = await http.post(url, headers: headers);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse["isSuccess"]) {
          debugPrint("캐릭터 설정 성공: ${jsonResponse["message"]}");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TermsScreen()),
          );
        } else {
          debugPrint("캐릭터 설정 실패: ${jsonResponse["message"]}");
        }
      } else {
        debugPrint("서버 오류 발생: 상태 코드 ${response.statusCode}");
        debugPrint("응답 본문: ${response.body}");
      }
    } catch (e) {
      debugPrint("네트워크 오류 발생: $e");
    }
  }
}
