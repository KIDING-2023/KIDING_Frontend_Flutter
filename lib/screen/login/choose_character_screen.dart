import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../home/home_screen.dart';

class ChooseCharacterScreen extends StatefulWidget {
  final String nickname;
  final int userId;

  ChooseCharacterScreen(
      {Key? key, required this.nickname, required this.userId})
      : super(key: key);

  @override
  _ChooseCharacterScreenState createState() => _ChooseCharacterScreenState();
}

class _ChooseCharacterScreenState extends State<ChooseCharacterScreen> {
  int _selectedCharacterIndex = -1;
  List<String> characterImages = [
    'assets/login/character1.png',
    'assets/login/character2.png',
    'assets/login/character3.png',
    'assets/login/character4.png',
  ];

  List<String> characterSelectedImages = [
    'assets/login/character1_selected.png',
    'assets/login/character2_selected.png',
    'assets/login/character3_selected.png',
    'assets/login/character4_selected.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      // 안내문
      Text(
        '안녕하세요 ${widget.nickname}님,\n캐릭터를 선택해주세요',
        style: TextStyle(
          fontFamily: 'Nanum',
          fontSize: 23,
          color: Colors.black,
          height: 1.77,
        ),
      ),
      // 로고
      Column(
        children: [
          Image.asset(
            'assets/login/character_logo.png',
            width: 249.93,
            height: 35.29,
          ),
          // 캐릭터 이미지
          Column(
            children: [
              for (int i = 0; i < characterImages.length; i += 2)
                Padding(
                  padding: const EdgeInsets.only(top: 22.71),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly, // 이미지를 균등하게 배치
                    children: [
                      for (int j = i;
                          j < i + 2 && j < characterImages.length;
                          j++)
                        GestureDetector(
                          onTap: () =>
                              setState(() => _selectedCharacterIndex = j),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: j % 2 == 0 ? 0 : 10.43,
                                right: j % 2 == 0 ? 10.43 : 0),
                            child: Image.asset(
                              _selectedCharacterIndex == j
                                  ? characterSelectedImages[j]
                                  : characterImages[j],
                              width: 114.25,
                              height: 114.25,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
      // 버튼
      Visibility(
        visible: _selectedCharacterIndex != -1,
        child: GestureDetector(
          onTap: () {
            // 데이터베이스 연결
            _chooseCharacter();
          },
          child: Image.asset('assets/login/character_start_btn.png',
              width: 312.22, height: 46.83),
        ),
      ),
    ]));
  }

  // API를 통한 캐릭터 설정 요청
  Future<void> _chooseCharacter() async {
    int num = _selectedCharacterIndex;

    var url =
        Uri.parse('http://3.37.76.76:8081/character/${widget.userId}/${num}');
    var response =
        await http.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      // 성공적인 처리, 홈 화면으로 이동
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(
                    userId: widget.userId,
                  )));
    } else {
      // 오류 메시지 로그 출력
      log('캐릭터 설정에 실패하였습니다.');
    }
  }
}
