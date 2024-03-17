import 'package:flutter/material.dart';

import '../home/home_screen.dart';

class ChooseCharacterScreen extends StatefulWidget {
  final String nickname;

  ChooseCharacterScreen({Key? key, required this.nickname}) : super(key: key);

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
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 53.5,
            top: 94.76,
            child: Text(
              '안녕하세요 ${widget.nickname}님,\n캐릭터를 선택해주세요',
              style: TextStyle(
                fontFamily: 'Nanum',
                fontSize: 23,
                color: Colors.black,
                height: 1.77,
              ),
            ),
          ),
          Positioned(
              left: 55.04,
              top: 215,
              child: Image.asset(
                'assets/login/character_logo.png',
                width: 249.93,
                height: 35.29,
              )),
          Positioned(
            top: 250.29,
            left: 39.3,
            right: 39.3,
            child: Column(
              children: [
                for (int i = 0; i < characterImages.length; i += 2)
                  Padding(
                    padding: const EdgeInsets.only(top: 22.71),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 이미지를 균등하게 배치
                      children: [
                        for (int j = i; j < i + 2 && j < characterImages.length; j++)
                          GestureDetector(
                            onTap: () => setState(() => _selectedCharacterIndex = j),
                            child: Padding(
                              padding: EdgeInsets.only(left: j % 2 == 0 ? 0 : 10.43, right: j % 2 == 0 ? 10.43 : 0),
                              child: Image.asset(
                                _selectedCharacterIndex == j ? characterSelectedImages[j] : characterImages[j],
                                width: 114.25,
                                height: 114.25,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                Visibility(
                  visible: _selectedCharacterIndex != -1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 168.34),
                    child: GestureDetector(
                      onTap: () {
                        // HomeScreen으로 화면을 전환합니다.
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                      },
                      child: Image.asset('assets/login/character_start_btn.png', width: 312.22, height: 46.83),
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
}
