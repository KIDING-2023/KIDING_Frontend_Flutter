import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kiding_frontend/core/constants/api_constants.dart';
import 'package:kiding_frontend/core/widgets/bottom_app_bar_widget.dart';
import 'package:kiding_frontend/screen/friends/friends_request_screen.dart';
import 'package:kiding_frontend/screen/ranking/ranking_friends_screen.dart';
import 'package:kiding_frontend/screen/search_screen.dart';

import 'package:http/http.dart' as http;

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  bool isSearchExpanded = false; // 검색창 확장 상태
  List<Map<String, dynamic>> rankingData = []; // 랭킹 데이터를 저장할 리스트
  final storage = FlutterSecureStorage();
  String? userNickname; // 저장된 닉네임

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

  // 닉네임 로드 함수
  Future<void> _loadNickname() async {
    String? nickname = await storage.read(key: 'nickname');
    setState(() {
      userNickname = nickname;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchRanking(); // 랭킹 데이터를 가져오기 위해 호출
    _loadNickname(); // 닉네임 불러오기
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FriendsRequestScreen()),
            );
          },
          child: Icon(Icons.notifications_none),
        ),
        title: Text(
          '랭킹',
          style: TextStyle(
            color: Color(0xFF4D4D4D),
            fontSize: 20,
            fontFamily: 'Nanum',
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                // 검색 화면으로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  ),
                );
              },
              child: Icon(Icons.search),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: BottomAppBarWidget(
          screenHeight: screenSize.height,
          screenWidth: screenSize.width,
          screen: "ranking",
          hasAppBar: true,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffE9EEFC),
          image: DecorationImage(
            image: AssetImage('assets/ranking/bg_line.png'), // 배경 이미지 경로
            fit: BoxFit.cover, // 이미지 크기 조정
          ),
        ),
        child: rankingData.isEmpty
            ? Center(child: CircularProgressIndicator()) // 로딩 표시
            : Stack(
                children: [
                  ..._buildRankingWidgets(screenSize), // 순위별 위젯 생성
                ],
              ),
      ),
    );
  }

  List<Widget> _buildRankingWidgets(Size screenSize) {
    List<Widget> widgets = [];
    List<double> topOffsets = [0.1205, 0.2116, 0.3088, 0.4688, 0.5814, 0.6811];
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

    for (int i = 0; i < rankingData.length && i < 6; i++) {
      final user = rankingData[i];
      widgets.add(
        Positioned(
          left: screenSize.width * leftPositions[i],
          top: screenSize.height * topOffsets[i],
          child: SizedBox(
            width: i < 3 ? 142 : 119,
            height: i < 3 ? 73 : 61,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  child: Container(
                    width: i < 3 ? 141.2 : 118.06,
                    height: i < 3 ? 72.67 : 60.76,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(36.33),
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          iconImages[i],
                          width: screenSize.width * (i < 3 ? 0.1819 : 0.1521),
                          height: screenSize.height * (i < 3 ? 0.0818 : 0.0684),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user["user"],
                              style: TextStyle(
                                fontSize: i < 3 ? 18 : 15,
                                fontFamily: 'Nanum',
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '${user["chips"]}개',
                              style: TextStyle(
                                fontSize: i < 3 ? 12 : 10,
                                fontFamily: 'Nanum',
                                color: Colors.black.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -10,
                  right: -15,
                  child: userNickname != null && userNickname == user["user"]
                      ? SizedBox.shrink()
                      : IconButton(
                          icon: Image.asset(
                            'assets/ranking/plus_btn.png',
                            width: 20,
                            height: 20,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RankingFriendsScreen(
                                  name: user["user"],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return widgets;
  }
}
