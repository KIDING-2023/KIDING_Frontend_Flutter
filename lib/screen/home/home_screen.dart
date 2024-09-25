import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kiding/screen/kikisday/kikisday_play_screen.dart';
import 'package:kiding/screen/ranking/ranking_screen.dart';

import '../mypage/mypage_screen.dart';
import '../space/space_play_screen.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _index = 0; // 기본으로 홈이 선택된 상태
  // Initialize selected index to 'Main'
  int _userId = 1; // 임시 사용자 ID (서버 연동 시 필요)
  int _selectedSortIndex = 0;
  bool _kikiStar = false;
  bool _spaceStar = false;
  String kikiStarImage = 'unselected_star.png';
  String spaceStarImage = 'unselected_star.png';

  List<Widget> _pages = [
    HomeScreen(),
    MyPageScreen(),
    RankingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; // 화면 크기
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white, // 배경색을 흰색으로 설정
        elevation: 0, // AppBar의 그림자 제거
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: IconButton(
            icon: Image.asset(
              'assets/home/menu.png',
              width: 21.65,
              height: 20,
            ),
            onPressed: () {},
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10, top: 10), // 검색 아이콘의 위치 조정
            child: IconButton(
              icon: Image.asset(
                'assets/home/search.png',
                width: 20.95,
                height: 20,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // 바디
          Positioned(
              top: 0,
              left: 0,
              child: SingleChildScrollView(
                child: SizedBox(
                  width: screenSize.width,
                  height: screenSize.height * 0.79,
                  child: Stack(
                    children: [
                      // let's play 텍스트
                      Positioned(
                          left: screenSize.width * 0.08,
                          top: screenSize.height * 0.04,
                          child: Image.asset(
                            'assets/home/home_title.png',
                            width: screenSize.width * 0.53,
                            height: screenSize.height * 0.07,
                          )),
                      // 메인, 인기순, 최근순 버튼
                      Positioned(
                        left: screenSize.width * 0.08,
                        top: screenSize.height * 0.15,
                        child: Row(
                          children: <Widget>[
                            _buildSortOption('메인', 0),
                            _buildSortOption('인기순', 1),
                            _buildSortOption('최근순', 2),
                          ],
                        ),
                      ),
                      // 카드 리스트
                      Positioned(
                        left: 0,
                        top: screenSize.height * 0.185,
                        child: Container(
                          width: screenSize.width,
                          child: Column(
                            children: <Widget>[
                              _buildMainSortSection(),
                            ],
                          ),
                        ),
                      ),
                      // 랭킹 박스
                      Positioned(
                          left: 0,
                          right: 0,
                          top: screenSize.height * 0.63,
                          child: Image.asset(
                            'assets/home/ranking_box.png',
                            width: screenSize.width * 0.83,
                            height: screenSize.height * 0.14,
                          )),
                      // 플러스 버튼
                      Positioned(
                          left: screenSize.width * 0.81,
                          top: screenSize.height * 0.64,
                          child: IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              'assets/home/plus.png',
                              width: screenSize.width * 0.06,
                              height: screenSize.height * 0.02,
                            ),
                          )),
                      // 1위 사용자 이름 (백엔드 연결 필요)
                      Positioned(
                        right: screenSize.width * 0.29,
                        top: screenSize.height * 0.715,
                        child: Text(
                          '사용자',
                          style: TextStyle(
                              fontSize: 18.96,
                              color: Colors.black,
                              fontFamily: 'Nanum'),
                        ),
                      ),
                      // 플레이 횟수 (백엔드 연결 필요)
                      Positioned(
                          left: screenSize.width * 0.73,
                          top: screenSize.height * 0.715,
                          child: Text(
                            '00번',
                            style: TextStyle(
                                fontSize: 18.96,
                                color: Color(0xff75777e),
                                fontFamily: 'Nanum'),
                          )),
                    ],
                  ),
                ),
              )),
          // 하단바 구분선
          Positioned(
              top: screenSize.height * 0.79,
              child: Container(
                width: screenSize.width,
                height: 0.1,
                color: Colors.black,
              )),
          // 하단바
          Positioned(
              top: screenSize.height * 0.8,
              left: 0,
              right: 0,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      icon: Image.asset(
                        'assets/home/ranking_unselected.png',
                        width: screenSize.width * 0.1,
                        height: screenSize.height * 0.04,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Image.asset(
                        'assets/home/home_selected.png',
                        width: screenSize.width * 0.1,
                        height: screenSize.height * 0.04,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Image.asset(
                        'assets/home/mypage_unselected.png',
                        width: screenSize.width * 0.1,
                        height: screenSize.height * 0.04,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyPageScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Widget _buildSortOption(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSortIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 25.0),
        child: Row(
          children: <Widget>[
            Image.asset(
              'assets/home/eclipse.png',
              width: 6.35,
              height: 6.35,
              color: _selectedSortIndex == index
                  ? Colors.orange
                  : Colors.transparent,
            ),
            SizedBox(width: 5),
            Text(
              title,
              style: TextStyle(
                color: _selectedSortIndex == index
                    ? Colors.black
                    : Color(0xFF75777E),
                fontSize: 14.22,
                fontFamily: 'Nanum',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainSortSection() {
    Size screenSize = MediaQuery.of(context).size; // 화면 크기
    return Container(
      height: screenSize.height * 0.4,
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.white.withOpacity(1.0), // 왼쪽의 불투명한 흰색
              Colors.white.withOpacity(0.0), // 중앙의 투명한 흰색
              Colors.white.withOpacity(0.0), // 중앙의 투명한 흰색
              Colors.white.withOpacity(1.0), // 오른쪽의 불투명한 흰색
            ],
            stops: [0.0, 0.15, 0.85, 1.0],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstOut, // 그라데이션 효과를 합성하는 방식
        child: ListView(
          padding: EdgeInsets.only(right: 30),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            _buildKikisdayCard(),
            _buildSpaceCard(),
            // 추가 카드를 이곳에 배치
          ],
        ),
      ),
    );
  }

  Widget _buildKikisdayCard() {
    Size screenSize = MediaQuery.of(context).size; // 화면 크기
    return GestureDetector(
      onTap: () {
        print('kikisday card tapped');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => KikisdayPlayScreen()),
        );
      },
      child: Container(
        width: screenSize.width * 0.64,
        margin: EdgeInsets.only(left: 30),
        child: Stack(
          children: <Widget>[
            Image.asset('assets/home/kikisday_card.png', fit: BoxFit.cover),
            // 박스 이미지
            Positioned(
              // '플레이 00명' 텍스트 위치 조정
              left: 20, // 이미지의 좌측으로부터의 거리
              top: 13.18, // 이미지의 상단으로부터의 거리
              child: Row(
                children: <Widget>[
                  Text('플레이 ',
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 11.38,
                          fontFamily: 'Nanum')),
                  Text('00',
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 11.38,
                          fontFamily: 'Nanum')),
                  Text('명',
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 11.38,
                          fontFamily: 'Nanum')),
                ],
              ),
            ),
            // 즐겨찾기 버튼
            Positioned(
                right: 15,
                top: 13.18,
                child: GestureDetector(
                    onTap: () {
                      // if (!_kikiStar) {
                      //   setState(() {
                      //     _kikiStar = true;
                      //     kikiStarImage = 'selected_star.png';
                      //   });
                      // } else {
                      //   setState(() {
                      //     _kikiStar = false;
                      //     kikiStarImage = 'unselected_star.png';
                      //   });
                      // }
                      _toggleFavorite(_userId, 1, _kikiStar); // 1은 Kikisday 게임의 ID
                    },
                    child: Image.asset('assets/home/$kikiStarImage',
                        width: 19.79, height: 19.79)))
          ],
        ),
      ),
    );
  }

  Widget _buildSpaceCard() {
    Size screenSize = MediaQuery.of(context).size; // 화면 크기
    return GestureDetector(
      onTap: () {
        print('space card tapped');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SpacePlayScreen()),
        );
      },
      child: Container(
        width: screenSize.width * 0.64,
        margin: EdgeInsets.only(left: 30),
        child: Stack(
          children: <Widget>[
            Image.asset('assets/home/space_card.png', fit: BoxFit.cover),
            // 박스 이미지
            Positioned(
              // '플레이 00명' 텍스트 위치 조정
              left: 20, // 이미지의 좌측으로부터의 거리
              top: 13.18, // 이미지의 상단으로부터의 거리
              child: Row(
                children: <Widget>[
                  Text('플레이 ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.38,
                          fontFamily: 'Nanum')),
                  Text('00',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.38,
                          fontFamily: 'Nanum')),
                  Text('명',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.38,
                          fontFamily: 'Nanum')),
                ],
              ),
            ),
            // 즐겨찾기 버튼
            Positioned(
                right: 15,
                top: 13.18,
                child: GestureDetector(
                    onTap: () {
                      // if (!_spaceStar) {
                      //   setState(() {
                      //     _spaceStar = true;
                      //     spaceStarImage = 'selected_star.png';
                      //   });
                      // } else {
                      //   setState(() {
                      //     _spaceStar = false;
                      //     spaceStarImage = 'unselected_star.png';
                      //   });
                      // }
                      _toggleFavorite(_userId, 2, _spaceStar); // 2는 Space 게임의 ID
                    },
                    child: Image.asset('assets/home/$spaceStarImage',
                        width: 19.79, height: 19.79)))
          ],
        ),
      ),
    );
  }

  // 즐겨찾기 토글 함수
  void _toggleFavorite(int userId, int boardgameId, bool isFavorite) async {
    String url = 'http://3.37.76.76:8081/bookmark/$userId/$boardgameId';
    try {
      var response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse["isSuccess"]) {
          setState(() {
            if (boardgameId == 1) {
              _kikiStar = !_kikiStar;
              kikiStarImage = _kikiStar ? 'selected_star.png' : 'unselected_star.png';
            } else if (boardgameId == 2) {
              _spaceStar = !_spaceStar;
              spaceStarImage = _spaceStar ? 'selected_star.png' : 'unselected_star.png';
            }
          });
          print(jsonResponse["message"]);
        } else {
          print("즐겨찾기 실패: ${jsonResponse["message"]}");
        }
      } else {
        print("서버 오류: 상태 코드 ${response.statusCode}");
      }
    } catch (e) {
      print("네트워크 오류: $e");
    }
  }
}
