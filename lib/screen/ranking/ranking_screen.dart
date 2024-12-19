import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kiding_frontend/core/constants/api_constants.dart';
import 'package:kiding_frontend/core/widgets/app_bar_widget.dart';
import 'package:kiding_frontend/core/widgets/bottom_app_bar_widget.dart';
import 'package:kiding_frontend/core/widgets/search_widget.dart';
import 'package:kiding_frontend/screen/friends/friends_request_screen.dart';
import 'package:kiding_frontend/screen/kikisday/kikisday_play_screen.dart';
import 'package:kiding_frontend/screen/space/space_play_screen.dart';

import 'package:http/http.dart' as http;

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  bool isSearchExpanded = false; // 검색창 확장 상태
  List<Map<String, dynamic>> rankingData = []; // 랭킹 데이터를 저장할 리스트

  Future<void> _fetchRanking() async {
    try {
      var response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.rankingEndpoint}/all'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          rankingData = List<Map<String, dynamic>>.from(data)
              .take(6)
              .toList(); // 상위 6명만 저장
        });
      } else {
        throw Exception('Failed to load ranking data');
      }
    } catch (error) {
      print("에러 발생: $error");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchRanking(); // 랭킹 데이터를 가져오기 위해 호출
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
        isSearchExpanded: isSearchExpanded,
        onSearchTap: () {
          setState(() {
            isSearchExpanded = !isSearchExpanded;
          });
        },
        onNotificationTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FriendsRequestScreen()),
          );
        },
        title: '랭킹',
        backgroundColor: Color(0xffE9EEFC),
      ),
      body: isSearchExpanded
          ? SearchWidget(
              screenSize: screenSize,
            )
          : Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: screenSize.width,
                    height: screenSize.height * 0.79,
                    decoration: BoxDecoration(
                      color: Color(0xffE9EEFC),
                    ),
                    child: rankingData.isEmpty
                        ? Center(child: CircularProgressIndicator()) // 로딩 표시
                        : Stack(
                            children: [
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Image.asset(
                                  'assets/ranking/bg_line.png',
                                  width: screenSize.width,
                                  height: screenSize.height * 0.79,
                                ),
                              ),
                              ..._buildRankingWidgets(screenSize), // 순위별 위젯 생성
                            ],
                          ),
                  ),
                ),
                Positioned(
                  top: screenSize.height * 0.79,
                  child: Container(
                    width: screenSize.width,
                    height: 0.1,
                    color: Colors.black,
                  ),
                ),
                // 하단 바
                BottomAppBarWidget(
                  screenHeight: screenSize.height,
                  screenWidth: screenSize.width,
                  screen: "ranking",
                  topPosition: screenSize.height * 0.8,
                  hasAppBar: true,
                )
              ],
            ),
    );
  }

  List<Widget> _buildRankingWidgets(Size screenSize) {
    List<Widget> widgets = [];
    List<double> topOffsets = [0.1205, 0.2116, 0.3088, 0.4688, 0.5814, 0.6811];
    List<String> containerImages = [
      'assets/ranking/big_container.png',
      'assets/ranking/big_container.png',
      'assets/ranking/big_container.png',
      'assets/ranking/small_container.png',
      'assets/ranking/small_container.png',
      'assets/ranking/small_container.png'
    ];
    List<String> iconImages = [
      'assets/ranking/big_icon_1.png',
      'assets/ranking/big_icon_2.png',
      'assets/ranking/big_icon_3.png',
      'assets/ranking/small_icon_1.png',
      'assets/ranking/small_icon_2.png',
      'assets/ranking/small_icon_3.png'
    ];
    List<double> leftPositions = [
      0.2028, // for 1st place
      0.523, // for 2nd place
      0.0865, // for 3rd place
      0.3888, // for 4th place
      0.59, // for 5th place
      0.3349 // for 6th place
    ];
    List<double> plusButtonLeftPositions = [
      0.5272, // for 1st place
      0.8439, // for 2nd place
      0.4106, // for 3rd place
      0.655, // for 4th place
      0.855, // for 5th place
      0.5994 // for 6th place
    ];
    List<double> plusButtonTopOffsets = [
      0.11,
      0.2013,
      0.2988,
      0.4588,
      0.5713,
      0.6713
    ];

    for (int i = 0; i < rankingData.length && i < 6; i++) {
      final user = rankingData[i];
      widgets.add(
        Positioned(
          left: screenSize.width * leftPositions[i],
          top: screenSize.height * topOffsets[i],
          child: Container(
            width:
                i < 3 ? screenSize.width * 0.3922 : screenSize.width * 0.3279,
            height:
                i < 3 ? screenSize.height * 0.0908 : screenSize.height * 0.076,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(containerImages[i]),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: screenSize.width * 0.0119,
                  top: screenSize.height * 0.0045,
                  child: Image.asset(
                    iconImages[i],
                    width: screenSize.width * (i < 3 ? 0.1819 : 0.1521),
                    height: screenSize.height * (i < 3 ? 0.0818 : 0.0684),
                  ),
                ),
                Positioned(
                  left: screenSize.width * (i < 3 ? 0.2028 : 0.1696),
                  top: screenSize.height * (i < 3 ? 0.0274 : 0.0223),
                  child: Text(
                    user["user"],
                    style: TextStyle(
                      fontSize: i < 3 ? 20 : 16.72,
                      fontFamily: 'Nanum',
                      color: Colors.black,
                    ),
                  ),
                ),
                Positioned(
                  left: screenSize.width * (i < 3 ? 0.203 : 0.1697),
                  top: screenSize.height * (i < 3 ? 0.0549 : 0.0459),
                  child: Text(
                    '${user["chips"]}개',
                    style: TextStyle(
                      fontSize: i < 3 ? 13 : 10.87,
                      fontFamily: 'Nanum',
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      // 플러스 버튼 추가
      widgets.add(
        Positioned(
          left: screenSize.width * plusButtonLeftPositions[i],
          top: screenSize.height * plusButtonTopOffsets[i],
          child: IconButton(
            icon: Image.asset(
              'assets/ranking/plus_btn.png',
              width: screenSize.width * 0.0556,
              height: screenSize.height * 0.025,
            ),
            onPressed: () {
              // Implement your onPressed function here
            },
          ),
        ),
      );
    }

    return widgets;
  }

  // 추천게임
  Widget _buildRecommends() {
    return SizedBox(
      height: 120,
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
            children: _buildRecommendCards()),
      ),
    );
  }

  // 추천 카드 목록을 생성
  List<Widget> _buildRecommendCards() {
    List<Widget> cards = [];
    cards.add(_buildRecommendCard1());
    cards.add(_buildRecommendCard2());
    return cards;
  }

  Widget _buildRecommendCard1() {
    return GestureDetector(
      onTap: () {
        print('kikisday card tapped');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => KikisdayPlayScreen()),
        );
      },
      child: Container(
        width: 230,
        margin: EdgeInsets.only(left: 30),
        child: Stack(
          children: <Widget>[
            Image.asset('assets/mypage/favorites_kikisday.png',
                fit: BoxFit.cover),
          ],
        ),
      ),
    );
  }

  // 임시 배치 (백엔드와 연결해야 함)
  Widget _buildRecommendCard2() {
    return GestureDetector(
      onTap: () {
        print('space card tapped');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SpacePlayScreen()),
        );
      },
      child: Container(
        width: 230,
        margin: EdgeInsets.only(left: 30),
        child: Stack(
          children: <Widget>[
            Image.asset('assets/mypage/favorites_space.png', fit: BoxFit.cover),
          ],
        ),
      ),
    );
  }
}
