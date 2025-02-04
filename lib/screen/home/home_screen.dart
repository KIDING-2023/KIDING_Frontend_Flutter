import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kiding_frontend/core/constants/api_constants.dart';

import 'package:http/http.dart' as http;
import 'package:kiding_frontend/core/widgets/app_bar_widget.dart';
import 'package:kiding_frontend/core/widgets/bottom_app_bar_widget.dart';
import 'package:kiding_frontend/screen/friends/friends_request_screen.dart';
import 'package:kiding_frontend/screen/kikisday/kikisday_play_screen.dart';
import 'package:kiding_frontend/screen/ranking/ranking_screen.dart';
import 'package:kiding_frontend/screen/space/space_play_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedSortIndex = 0;
  String kikiStarImage = 'unselected_star.png';
  String spaceStarImage = 'unselected_star.png';
  final storage = FlutterSecureStorage(); // Secure Storage 인스턴스 생성

  // 보드게임 리스트
  List<dynamic> _boardGames = [];
  bool isLoading = false;
  String errorMessage = "";

  // 오늘의 랭킹 (1워 사용자 정보)
  String nickname = '사용자';
  int answers = 0;

  @override
  void initState() {
    super.initState();
    _fetchBoardGames(); // initState에서 한 번만 호출
    _loadTodaysRanking();
  }

  // 보드게임 데이터를 서버로부터 가져오는 함수
  Future<void> _fetchBoardGames() async {
    // 토큰 불러오기
    String? token = await storage.read(key: 'accessToken');

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

    var url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.boardgamesEndpoint}/$sortOption');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);
      log('보드게임 Response Status Code: ${response.statusCode}');
      log('보드게임 Response Body: ${response.body}'); // 서버 응답 본문 출력

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["isSuccess"]) {
          log('보드게임 데이터: ${data['result']}'); // 서버 응답 데이터 출력
          if (data["message"] == "아직 보드게임에 참여하지 않았습니다.") {
            setState(() {
              _boardGames = [];
              isLoading = false;
            });
          } else {
            // 중복 제거
            final uniqueGames = _removeDuplicatesByName(data['result']);

            setState(() {
              _boardGames = uniqueGames; // 중복 제거된 데이터 저장
              isLoading = false;
            });
          }
        } else {
          log("보드게임 가져오기 실패: ${data["message"]}");
          setState(() {
            errorMessage = data["message"];
            isLoading = false;
          });
        }
      } else {
        log("서버 오류: 상태 코드 ${response.statusCode}");
        setState(() {
          errorMessage = "서버 오류: ${response.statusCode}";
          isLoading = false;
        });
      }
    } catch (e) {
      log("네트워크 오류: $e");
      setState(() {
        errorMessage = "네트워크 오류: $e";
        isLoading = false;
      });
    }
  }

  // 중복 제거 함수
  List<dynamic> _removeDuplicatesByName(List<dynamic> games) {
    final seenNames = <String>{}; // 중복 확인용 Set
    return games.where((game) {
      final name = game['name'];
      if (seenNames.contains(name)) {
        return false; // 중복된 경우 제외
      } else {
        seenNames.add(name);
        return true; // 새로운 항목만 포함
      }
    }).toList();
  }

  // 즐겨찾기 상태를 서버에 업데이트하는 함수
  Future<void> _updateFavoriteStatus(int boardGameId, bool isFavorite) async {
    String? token = await storage.read(key: 'accessToken');

    var url = isFavorite
        ? Uri.parse('${ApiConstants.baseUrl}/bookmark/$boardGameId')
        : Uri.parse('${ApiConstants.baseUrl}/bookmark/delete/$boardGameId');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.post(url, headers: headers);
      log('즐겨찾기 업데이트 응답 코드: ${response.statusCode}');
      log('응답 본문: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['isSuccess']) {
          log("즐겨찾기 업데이트 성공: ${data['message']}");
        } else {
          log("즐겨찾기 업데이트 실패: ${data['message']}");
        }
      } else {
        log("서버 오류: 상태 코드 ${response.statusCode}");
      }
    } catch (e) {
      log("네트워크 오류: $e");
    }
  }

  // 오늘의 랭킹 정보를 불러오는 함수
  Future<void> _loadTodaysRanking() async {
    var url = Uri.parse('${ApiConstants.baseUrl}/ranking/today');
    var headers = {
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);
      log('오늘의 랭킹 응답 코드: ${response.statusCode}');
      log('응답 본문: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['isSuccess']) {
          log("오늘의 랭킹 불러오기 성공: ${data['message']}");
          nickname = data['result']['nickname'];
          answers = data['result']['answers'];
        } else {
          log("오늘의 랭킹 불러오기 실패: ${data['message']}");
        }
      } else {
        log("서버 오류: 상태 코드 ${response.statusCode}");
      }
    } catch (e) {
      log("네트워크 오류: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; // 화면 크기
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
        onNotificationTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FriendsRequestScreen()),
          );
        },
        title: '',
        backgroundColor: Colors.white,
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
                        left: screenSize.width * 0.1,
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
                        top: screenSize.height * 0.19,
                        child: SizedBox(
                          width: screenSize.width,
                          height: screenSize.height * 0.6,
                          child: Column(
                            children: <Widget>[_buildBoardGamesSection()],
                          ),
                        ),
                      ),
                      // 랭킹 박스
                      Positioned(
                        left: 0,
                        right: 0,
                        top: screenSize.height * 0.62,
                        child: Center(
                          child: Container(
                            width: 300.17,
                            height: 111,
                            padding: EdgeInsets.all(10),
                            decoration: ShapeDecoration(
                              color: Color(0xFFE8EEFB),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.96),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/home/award.png',
                                            width: 21.81,
                                          ),
                                          Text(
                                            '오늘의 랭킹',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.96,
                                              fontFamily: 'Nanum',
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ],
                                      ),
                                      // 더보기 버튼
                                      GestureDetector(
                                        onTap: () {
                                          // 랭킹 화면으로 이동
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RankingScreen()),
                                          );
                                        },
                                        child: Icon(
                                          Icons.add,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 280.38,
                                  height: 40.40,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(19.46),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '1위',
                                        style: TextStyle(
                                          color: Color(0xFFFF8A5B),
                                          fontSize: 18.96,
                                          fontFamily: 'Nanum',
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            nickname,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.96,
                                              fontFamily: 'Nanum',
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            '$answers번',
                                            style: TextStyle(
                                              color: Color(0xFF75777E),
                                              fontSize: 18.96,
                                              fontFamily: 'Nanum',
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          // 하단바
          BottomAppBarWidget(
            screenHeight: screenSize.height,
            screenWidth: screenSize.width,
            screen: "home",
            hasAppBar: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSortOption(String title, int index) {
    Size screenSize = MediaQuery.of(context).size;

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
              width: screenSize.width * 0.0176,
              color: _selectedSortIndex == index
                  ? Colors.orange
                  : Colors.transparent,
            ),
            SizedBox(width: screenSize.width * 0.0139),
            Text(
              title,
              style: TextStyle(
                color: _selectedSortIndex == index
                    ? Colors.black
                    : Color(0xFF75777E),
                fontSize: screenSize.height * 0.0178,
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
      log("보드게임 없음");
      return SizedBox(
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
    return SizedBox(
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
    String gameName = game['name'];
    Widget nextScreen =
        gameName == "키키의 하루" ? KikisdayPlayScreen() : SpacePlayScreen();

    // Assign a default ID if the game ID is not present
    if (game['id'] == null) {
      if (gameName == "키키의 하루") {
        game['id'] = 1;
      } else if (gameName == "우주 여행") {
        game['id'] = 2;
      }
    }

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
        width: screenSize.width * 0.51,
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
              right: screenSize.width * 0.03,
              top: 13.18,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    // 로컬 즐겨찾기 상태 업데이트
                    game['bookmarked'] = !game['bookmarked'];
                  });
                  // 서버에 즐겨찾기 상태 업데이트 요청
                  _updateFavoriteStatus(game['id'], game['bookmarked']);
                  log("즐겨찾기 상태: ${game['bookmarked']}");
                },
                child: Image.asset(
                    'assets/home/${game['bookmarked'] ? 'selected_star.png' : 'unselected_star.png'}',
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
