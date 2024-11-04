import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kiding/constants/api_constants.dart';
import 'package:kiding/screen/friends/friends_request_screen.dart';
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
  final storage = FlutterSecureStorage(); // Secure Storage 인스턴스 생성

  List<Widget> _pages = [
    HomeScreen(),
    MyPageScreen(),
    RankingScreen(),
  ];

  // 보드게임 리스트
  List<dynamic> _boardGames = [];
  bool isLoading = true;
  String errorMessage = "";

  bool isSearchExpanded = false; // 검색창 확장 상태

  @override
  void initState() {
    super.initState();
    _fetchBoardGames(); // initState에서 한 번만 호출
  }

  // 보드게임 데이터를 서버로부터 가져오는 함수
  Future<void> _fetchBoardGames() async {
    // 토큰 불러오기
    String? token = await storage.read(key: 'accessToken');
    if (token == null) {
      print("토큰이 없습니다.");
      setState(() {
        errorMessage = "토큰이 없습니다.";
        isLoading = false;
      });
      return;
    }

    // 정렬 옵션에 따라 URL 설정
    String sortOption;
    switch (_selectedSortIndex) {
      case 1:
        sortOption = 'popular';
        break;
      case 2:
        sortOption = 'recent';
        break;
      default:
        sortOption = 'main';
        break;
    }

    var url = Uri.parse('${ApiConstants.baseUrl}/boardgames/$sortOption');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);
      print('보드게임 Response Status Code: ${response.statusCode}');
      print('보드게임 Response Body: ${response.body}'); // 서버 응답 본문 출력

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["isSuccess"]) {
          print('보드게임 데이터: ${data['result']}'); // 서버 응답 데이터 출력
          if (data["message"] == "아직 보드게임에 참여하지 않았습니다.") {
            setState(() {
              _boardGames = [];
              isLoading = false;
            });
          } else {
            setState(() {
              _boardGames = data['result']; // 서버로부터 받은 보드게임 데이터 저장
              isLoading = false;
            });
          }
        } else {
          print("보드게임 가져오기 실패: ${data["message"]}");
          setState(() {
            errorMessage = data["message"];
            isLoading = false;
          });
        }
      } else {
        print("서버 오류: 상태 코드 ${response.statusCode}");
        setState(() {
          errorMessage = "서버 오류: ${response.statusCode}";
          isLoading = false;
        });
      }
    } catch (e) {
      print("네트워크 오류: $e");
      setState(() {
        errorMessage = "네트워크 오류: $e";
        isLoading = false;
      });
    }
  }

  // 즐겨찾기 상태를 서버에 업데이트하는 함수
  Future<void> _updateFavoriteStatus(int boardGameId, bool isFavorite) async {
    String? token = await storage.read(key: 'accessToken');
    if (token == null) {
      print("토큰이 없습니다.");
      return;
    }

    var url = Uri.parse('${ApiConstants.baseUrl}/bookmark/$boardGameId');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(url, headers: headers);
      print('즐겨찾기 업데이트 응답 코드: ${response.statusCode}');
      print('응답 본문: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['isSuccess']) {
          print("즐겨찾기 업데이트 성공: ${data['message']}");
        } else {
          print("즐겨찾기 업데이트 실패: ${data['message']}");
        }
      } else {
        print("서버 오류: 상태 코드 ${response.statusCode}");
      }
    } catch (e) {
      print("네트워크 오류: $e");
    }
  }

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
              'assets/home/notice.png',
              width: 17.08,
              height: 20,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FriendsRequestScreen()),
              );
            },
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15, top: 10),
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              width: isSearchExpanded ? screenSize.width * 0.8333 : 40,
              height: screenSize.height * 0.0563,
              decoration: BoxDecoration(
                color: isSearchExpanded ? Color(0xffff8a5b) : Colors.white,
                borderRadius: BorderRadius.circular(27.36),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (isSearchExpanded)
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        ),
                      ),
                    ),
                  Flexible(
                    child: IconButton(
                      icon: Image.asset(
                        isSearchExpanded
                            ? 'assets/home/search_icon_selected.png'
                            : 'assets/home/search.png',
                        width: 20.95,
                        height: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          isSearchExpanded = !isSearchExpanded;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: isSearchExpanded
          ? Stack(
              children: [
                // 추천 게임 텍스트
                Positioned(
                  left: screenSize.width * 0.082,
                  top: screenSize.height * 0.6,
                  child: Text(
                    '추천 게임',
                    style: TextStyle(
                      fontFamily: 'Nanum',
                      fontSize: 14.22,
                      color: Color(0xff868686),
                    ),
                  ),
                ),
                // 추천 카드덱 리스트
                Positioned(
                  top: screenSize.height * 0.63,
                  child: Container(
                    width: screenSize.width,
                    child: Column(
                      children: <Widget>[
                        _buildRecommends(),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Stack(
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
                                height: screenSize.height * 0.6,
                                child: Column(
                                  children: <Widget>[
                                    _buildBoardGamesSection()
                                    // if (_selectedSortIndex == 0)
                                    //   _buildMainSortSection(),
                                    // if (_selectedSortIndex == 1)
                                    //   _buildPopularSortSection(),
                                    // if (_selectedSortIndex == 2)
                                    //   _buildRecentSortSection(),
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RankingScreen()),
                              );
                            },
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

  // 추천게임
  Widget _buildRecommends() {
    return Container(
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

  Widget _buildSortOption(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSortIndex = index; // 선택된 정렬 옵션을 업데이트
          _fetchBoardGames(); // 선택된 정렬 옵션에 맞는 데이터를 다시 가져옴
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

  Widget _buildBoardGamesSection() {
    Size screenSize = MediaQuery.of(context).size; // 화면 크기

    // 로딩 중일 때 로딩 표시
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    // 보드게임 데이터가 없을 때
    if (_boardGames.isEmpty) {
      return Container(
        width: screenSize.width * 0.8,
        height: screenSize.height * 0.6,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/home/no_game.png',
                width: screenSize.width * 0.8333,
                height: screenSize.height * 0.3135375,
              ),
            )
          ],
        ),
      );
    }

    // 보드게임 데이터를 정상적으로 가져왔을 때
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
        child: ListView.builder(
          padding: EdgeInsets.only(right: 30),
          scrollDirection: Axis.horizontal,
          itemCount: _boardGames.length, // itemCount를 _boardGames.length로 설정
          itemBuilder: (context, index) {
            var game = _boardGames[index];
            return _buildBoardGameCard(game);
          },
        ),
      ),
    );
  }

  Widget _buildBoardGameCard(dynamic game) {
    Size screenSize = MediaQuery.of(context).size;
    bool isFavorite = game['bookmarked'];
    String gameName = game['name'];
    Widget nextScreen =
        gameName == "키키의 하루" ? KikisdayPlayScreen() : SpacePlayScreen();

    // gameImage 초기화
    String gameImage = gameName == "키키의 하루" ? "kikisday" : "space";

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextScreen),
        );
      },
      child: Container(
        width: screenSize.width * 0.64,
        margin: EdgeInsets.only(left: 30),
        child: Stack(
          children: <Widget>[
            Image.asset('assets/home/${gameImage}_card.png', fit: BoxFit.cover),
            Positioned(
              left: 20,
              top: 13.18,
              child: Row(
                children: <Widget>[
                  Text('플레이 ${game['players']}명',
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 11.38,
                          fontFamily: 'Nanum')),
                ],
              ),
            ),
            Positioned(
              right: 15,
              top: 13.18,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    // 로컬 즐겨찾기 상태 업데이트
                    isFavorite = !isFavorite;
                  });
                  // 서버에 즐겨찾기 상태 업데이트 요청
                  _updateFavoriteStatus(game['id'], isFavorite);
                },
                child: Image.asset(
                    'assets/home/${isFavorite ? 'selected_star.png' : 'unselected_star.png'}',
                    width: 19.79,
                    height: 19.79),
              ),
            )
          ],
        ),
      ),
    );
  }
}
