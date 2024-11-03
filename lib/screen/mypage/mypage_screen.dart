import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../friends/friends_request_screen.dart';
import '../home/home_screen.dart';
import '../kikisday/kikisday_play_screen.dart';
import '../space/space_play_screen.dart';

import 'package:http/http.dart' as http;

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  List<bool> _isFavoriteList = [false, false]; // 각 카드의 즐겨찾기 상태를 관리
  List<dynamic> favoriteGames = []; // 서버로부터 받은 즐겨찾기 데이터를 저장
  final storage = FlutterSecureStorage(); // Secure Storage 인스턴스 생성
  bool isLoading = true;
  String errorMessage = "";

  // 사용자 정보 변수
  String nickname = "";
  int answers = 0;
  int score = 0;
  int playersWith = 0;
  int kidingChip = 0;

  // 애니메이션 위젯에서 사용할 사용자 데이터
  late int chipsNum;
  late int friendsNum;
  late int rankingNum;

  bool isSearchExpanded = false; // 검색창 확장 상태

  @override
  void initState() {
    super.initState();
    fetchMyPageData(); // 서버에서 마이페이지 데이터 가져오기
    fetchFavoriteGames();
  }

  // 서버에서 사용자 정보 가져오기
  Future<void> fetchMyPageData() async {
    String? token = await storage.read(key: 'accessToken'); // 토큰 불러오기
    if (token == null) {
      setState(() {
        errorMessage = "토큰을 찾을 수 없습니다.";
        isLoading = false;
      });
      return;
    }

    var url = Uri.parse('https://6a4c-182-209-67-24.ngrok-free.app/mypage');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}'); // 서버로부터 받은 응답 로그 출력

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['isSuccess']) {
          // 응답이 성공일 경우 데이터 업데이트
          setState(() {
            nickname = data['result']['nickname'];
            answers = data['result']['answers'];
            score = data['result']['score'];
            playersWith = data['result']['players_with'];
            kidingChip = data['result']['kiding_chip'];
            chipsNum = kidingChip; // 애니메이션 위젯에 데이터 적용
            friendsNum = playersWith; // 친구 수 적용
            rankingNum = score; // 랭킹 수 적용
            isLoading = false; // 로딩 상태 해제
          });
        } else {
          setState(() {
            errorMessage = data['message'];
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = "서버 오류: ${response.statusCode}";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "네트워크 오류: $e";
        isLoading = false;
      });
    }
  }

  // 즐겨찾기 보드게임 데이터를 서버로부터 가져오는 함수
  Future<void> fetchFavoriteGames() async {
    String? token = await storage.read(key: 'accessToken');
    if (token == null) {
      setState(() {
        errorMessage = "토큰을 찾을 수 없습니다.";
        isLoading = false;
      });
      return;
    }

    var url = Uri.parse('https://6a4c-182-209-67-24.ngrok-free.app/bookmark');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}'); // 서버로부터 받은 응답 로그 출력

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['isSuccess']) {
          // 응답이 성공일 경우 데이터 업데이트
          setState(() {
            favoriteGames = data['result'];
            // _isFavoriteList 값을 설정
            _isFavoriteList[0] =
                favoriteGames.any((game) => game['boardGameId'] == 1);
            _isFavoriteList[1] =
                favoriteGames.any((game) => game['boardGameId'] == 2);
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = data['message'];
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = "서버 오류: ${response.statusCode}";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "네트워크 오류: $e";
        isLoading = false;
      });
    }
  }

  // GlobalKey를 사용하여 각 애니메이션 아이템의 상태를 참조
  final GlobalKey<ChipsItemState> _chipsItemKey = GlobalKey<ChipsItemState>();
  final GlobalKey<FriendsItemState> _friendsItemKey =
      GlobalKey<FriendsItemState>();
  final GlobalKey<RankingItemState> _rankingItemKey =
      GlobalKey<RankingItemState>();
  final GlobalKey<TriangleItemState> _triangleItemKey =
      GlobalKey<TriangleItemState>();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (isLoading) {
      return Center(child: CircularProgressIndicator()); // 로딩 표시
    }

    if (errorMessage.isNotEmpty) {
      return Center(child: Text(errorMessage)); // 오류 메시지 표시
    }

    return Scaffold(
        backgroundColor: Colors.white,
        // 상단바
        appBar: AppBar(
          backgroundColor: Colors.white,
          // 배경색을 흰색으로 설정
          elevation: 0,
          // AppBar의 그림자 제거
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
                  MaterialPageRoute(
                      builder: (context) => FriendsRequestScreen()),
                );
              },
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              '마이페이지',
              style: TextStyle(
                color: Colors.black, // 텍스트 색상
                fontSize: 18, // 텍스트 크기
                fontFamily: 'Nanum', // 폰트
              ),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10, top: 10),
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
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
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
        // 바디
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
                  Positioned(
                    top: 0,
                    left: 0,
                    child: SingleChildScrollView(
                        child: SizedBox(
                      width: screenSize.width,
                      height: screenSize.height * 0.79,
                      child: Stack(
                        children: [
                          // 오늘의 랭킹 박스
                          Positioned(
                              top: screenSize.height * 0.03,
                              left: 0,
                              right: 0,
                              child: Image.asset(
                                'assets/mypage/ranking_box_mypage.png',
                                width: screenSize.width * 0.84,
                                height: screenSize.height * 0.15,
                              )),
                          // 대답수 8번 (임시 - 백엔드와 연동 필요)
                          Positioned(
                              left: screenSize.width * 0.19,
                              top: screenSize.height * 0.105,
                              child: Text(
                                '대답수 $answers번',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'Nanum',
                                    color: Color(0xffff8a5b).withOpacity(0.5)),
                              )),
                          // 4위 (임시 - 백엔드 연동 필요)
                          Positioned(
                              left: screenSize.width * 0.698,
                              top: screenSize.height * 0.105,
                              child: Text(
                                '$score위',
                                style: TextStyle(
                                  fontFamily: 'Nanum',
                                  fontSize: 25,
                                  color: Color(0xffff8a5b),
                                ),
                              )),
                          // 동점자: 12명 (임시 - 백엔드 연동 필요) -- 위젯 안 보이는 문제 해결 필요
                          Positioned(
                              top: screenSize.height * 0.153,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Text(
                                  '동점자: $playersWith명',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Nanum',
                                      color:
                                          Color(0xffff8a5b).withOpacity(0.7)),
                                ),
                              )),
                          // 즐겨찾기 텍스트
                          Positioned(
                              left: screenSize.width * 0.082,
                              top: screenSize.height * 0.209,
                              child: Image.asset(
                                'assets/mypage/favorites_text.png',
                                width: screenSize.width * 0.158,
                                height: screenSize.height * 0.021,
                              )),
                          // 즐겨찾기한 카드덱 리스트
                          Positioned(
                            top: screenSize.height * 0.236,
                            child: Container(
                              width: screenSize.width,
                              child: Column(
                                children: <Widget>[
                                  _buildFavorites(),
                                ],
                              ),
                            ),
                          ),
                          // 나의 기록 텍스트
                          Positioned(
                              left: screenSize.width * 0.082,
                              top: screenSize.height * 0.416,
                              child: Image.asset(
                                'assets/mypage/my_record_text.png',
                                width: screenSize.width * 0.169,
                                height: screenSize.height * 0.021,
                              )),
                          // 새로고침 버튼
                          Positioned(
                              left: screenSize.width * 0.835,
                              top: screenSize.height * 0.4,
                              child: IconButton(
                                icon: Image.asset(
                                  'assets/mypage/reset_btn.png',
                                  width: screenSize.width * 0.043,
                                  height: screenSize.height * 0.019,
                                ),
                                onPressed: _restartAnimations,
                              )),
                          // 나의 기록 박스
                          Positioned(
                              top: screenSize.height * 0.444,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/mypage/my_record_bg.png'),
                                          fit: BoxFit.fill)),
                                  width: screenSize.width * 0.835,
                                  height: screenSize.height * 0.576,
                                  child: Stack(
                                    children: [
                                      // 키딩칩 개수
                                      ChipsItem(
                                          key: _chipsItemKey,
                                          chipsNum: chipsNum),
                                      // 친구 수
                                      FriendsItem(
                                          key: _friendsItemKey,
                                          friendsNum: friendsNum),
                                      // 1위 경험 횟수
                                      RankingItem(
                                          key: _rankingItemKey,
                                          rankingNum: rankingNum),
                                      // 삼각형 모양
                                      TriangleItem(key: _triangleItemKey)
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ),
                    )),
                  ),
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
                                'assets/mypage/ranking_unselected.png',
                                width: screenSize.width * 0.1,
                                height: screenSize.height * 0.04,
                              ),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Image.asset(
                                'assets/mypage/home_unselected.png',
                                width: screenSize.width * 0.1,
                                height: screenSize.height * 0.04,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                );
                              },
                            ),
                            IconButton(
                              icon: Image.asset(
                                'assets/mypage/mypage_selected.png',
                                width: screenSize.width * 0.1,
                                height: screenSize.height * 0.04,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ))
                ],
              ));
  }

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

  Widget _buildFavorites() {
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
            children: _buildFavoriteCards()),
      ),
    );
  }

  // 즐겨찾기 카드 목록을 생성
  List<Widget> _buildRecommendCards() {
    List<Widget> cards = [];
    cards.add(_buildRecommendCard1());
    cards.add(_buildRecommendCard2());
    return cards;
  }

  // 즐겨찾기 카드 목록을 생성
  List<Widget> _buildFavoriteCards() {
    List<Widget> cards = [];
    if (_isFavoriteList[0]) {
      cards.add(_buildFavoriteCard1());
    }
    if (_isFavoriteList[1]) {
      cards.add(_buildFavoriteCard2());
    }
    return cards;
  }

  // 즐겨찾기 버튼을 클릭했을 때 호출되는 함수
  void _toggleFavorite(int index) {
    setState(() {
      _isFavoriteList[index] = !_isFavoriteList[index];
    });
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

  // 임시 배치 (백엔드와 연결해야 함)
  Widget _buildFavoriteCard1() {
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
            // 즐겨찾기 버튼
            Positioned(
                left: 15,
                top: 13.18,
                child: GestureDetector(
                    onTap: () {
                      _toggleFavorite(0);
                    },
                    child: Image.asset('assets/home/selected_star.png',
                        width: 19.79, height: 19.79)))
          ],
        ),
      ),
    );
  }

  // 임시 배치 (백엔드와 연결해야 함)
  Widget _buildFavoriteCard2() {
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
            // 즐겨찾기 버튼
            Positioned(
                left: 15,
                top: 13.18,
                child: GestureDetector(
                    onTap: () {
                      _toggleFavorite(1);
                    },
                    child: Image.asset('assets/home/selected_star.png',
                        width: 19.79, height: 19.79)))
          ],
        ),
      ),
    );
  }

  // 새로고침
  void _restartAnimations() {
    _chipsItemKey.currentState
        ?.restartAnimation(MediaQuery.of(context).size.height);
    _friendsItemKey.currentState
        ?.restartAnimation(MediaQuery.of(context).size.height);
    _rankingItemKey.currentState
        ?.restartAnimation(MediaQuery.of(context).size.height);
    _triangleItemKey.currentState
        ?.restartAnimation(MediaQuery.of(context).size.height);
  }
}

// 키딩칩 개수
class ChipsItem extends StatefulWidget {
  final int chipsNum;

  const ChipsItem({super.key, required this.chipsNum});

  @override
  State<ChipsItem> createState() => ChipsItemState();
}

class ChipsItemState extends State<ChipsItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _chipsController;
  late Animation<double> _chipsAnimation;
  double _chipsTopPosition = 0; // 초기 위치 값 변경

  @override
  void initState() {
    super.initState();
    _chipsController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // initState에서는 MediaQuery.of(context)를 사용할 수 없으므로, 애니메이션 초기화는 나중에 함.
  }

  @override
  void dispose() {
    _chipsController.dispose();
    super.dispose();
  }

  void restartAnimation(double screenHeight) {
    _chipsTopPosition = -0.3 * screenHeight; // 화면 높이의 -30%로 위치 설정
    _chipsAnimation =
        Tween<double>(begin: _chipsTopPosition, end: -_chipsTopPosition)
            .animate(
      CurvedAnimation(parent: _chipsController, curve: Curves.bounceOut),
    );

    _chipsController.addListener(() {
      setState(() {
        _chipsTopPosition = _chipsAnimation.value;
      });
    });

    _chipsController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // 애니메이션이 완료되면 컨트롤러를 정지
        _chipsController.stop();
      }
    });

    _chipsController.reset();
    _chipsController.forward();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; // 화면 크기
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;

    // 애니메이션을 화면 크기 기준으로 시작
    if (_chipsController.status == AnimationStatus.dismissed) {
      restartAnimation(screenHeight);
    }

    return Positioned(
      top: _chipsTopPosition,
      left: 0.06 * screenWidth, // 화면 너비의 6%로 위치 설정
      child: Transform.rotate(
        angle: pi / 7,
        child: Container(
          width: 0.5 * screenWidth, // 화면 너비의 50%로 크기 설정
          height: 0.5 * screenWidth, // 화면 너비의 50%로 크기 설정
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/mypage/chips_bg.png'),
                  fit: BoxFit.fill)),
          child: Padding(
            padding: EdgeInsets.only(top: 0.3 * 0.5 * screenWidth),
            // 이미지 높이의 30%로 패딩 설정
            child: Center(
              child: Text(
                '${widget.chipsNum}개',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 0.08 * screenWidth,
                    fontFamily: 'Nanum'), // 화면 너비의 8%로 폰트 크기 설정
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 친구 수
class FriendsItem extends StatefulWidget {
  final int friendsNum;

  const FriendsItem({super.key, required this.friendsNum});

  @override
  State<FriendsItem> createState() => FriendsItemState();
}

class FriendsItemState extends State<FriendsItem>
    with SingleTickerProviderStateMixin {
  int friendsNum = 3; // 친구 수 임시

  late AnimationController _friendsController;
  late Animation<double> _friendsAnimation;
  double _friendsTopPosition = 0; // 초기 위치 값 변경

  @override
  void initState() {
    super.initState();
    _friendsController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // initState에서는 MediaQuery.of(context)를 사용할 수 없으므로, 애니메이션 초기화는 나중에 함.
  }

  @override
  void dispose() {
    _friendsController.dispose();
    super.dispose();
  }

  void restartAnimation(double screenHeight) {
    _friendsTopPosition = -0.135 * screenHeight; // 화면 높이의 -10%로 위치 설정
    _friendsAnimation =
        Tween<double>(begin: _friendsTopPosition, end: -_friendsTopPosition)
            .animate(
      CurvedAnimation(parent: _friendsController, curve: Curves.bounceOut),
    );

    _friendsController.addListener(() {
      setState(() {
        _friendsTopPosition = _friendsAnimation.value;
      });
    });

    _friendsController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // 애니메이션이 완료되면 컨트롤러를 정지
        _friendsController.stop();
      }
    });

    _friendsController.reset();
    _friendsController.forward();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; // 화면 크기
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;

    // 애니메이션을 화면 크기 기준으로 시작
    if (_friendsController.status == AnimationStatus.dismissed) {
      restartAnimation(screenHeight);
    }

    return Positioned(
      top: _friendsTopPosition,
      right: 0.01 * screenWidth, // 화면 너비의 5%로 위치 설정
      child: Transform.rotate(
        angle: -pi / 7,
        child: Container(
          width: 0.45 * screenWidth, // 화면 너비의 45%로 크기 설정
          height: 0.45 * screenWidth, // 화면 너비의 45%로 크기 설정
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/mypage/friends_bg.png'),
                  fit: BoxFit.fill)),
          child: Padding(
            padding: EdgeInsets.only(top: 0.25 * 0.45 * screenWidth),
            // 이미지 높이의 25%로 패딩 설정
            child: Center(
              child: Text(
                "${widget.friendsNum}명",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 0.07 * screenWidth,
                    fontFamily: 'Nanum'), // 화면 너비의 7%로 폰트 크기 설정
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 1위 경험
class RankingItem extends StatefulWidget {
  final int rankingNum;

  const RankingItem({super.key, required this.rankingNum});

  @override
  State<RankingItem> createState() => RankingItemState();
}

class RankingItemState extends State<RankingItem>
    with SingleTickerProviderStateMixin {
  int rankingNum = 5; // 1위 경험 횟수 임시

  late AnimationController _rankingController;
  late Animation<double> _rankingAnimation;
  double _rankingTopPosition = 0; // 초기 위치 값 변경

  @override
  void initState() {
    super.initState();
    _rankingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // initState에서는 MediaQuery.of(context)를 사용할 수 없으므로, 애니메이션 초기화는 나중에 함.
  }

  @override
  void dispose() {
    _rankingController.dispose();
    super.dispose();
  }

  void restartAnimation(double screenHeight) {
    _rankingTopPosition = -0.06 * screenHeight; // 화면 높이의 -5%로 위치 설정
    _rankingAnimation =
        Tween<double>(begin: _rankingTopPosition, end: -_rankingTopPosition)
            .animate(
      CurvedAnimation(parent: _rankingController, curve: Curves.bounceOut),
    );

    _rankingController.addListener(() {
      setState(() {
        _rankingTopPosition = _rankingAnimation.value;
      });
    });

    _rankingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // 애니메이션이 완료되면 컨트롤러를 정지
        _rankingController.stop();
      }
    });

    _rankingController.reset();
    _rankingController.forward();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; // 화면 크기
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;

    // 애니메이션을 화면 크기 기준으로 시작
    if (_rankingController.status == AnimationStatus.dismissed) {
      restartAnimation(screenHeight);
    }

    return Positioned(
      top: _rankingTopPosition,
      left: -0.01 * screenWidth, // 화면 너비의 -2%로 위치 설정
      child: Transform.rotate(
        angle: -pi / 20,
        child: Container(
          width: 0.46 * screenWidth, // 화면 너비의 40%로 크기 설정
          height: 0.46 * screenWidth, // 화면 너비의 40%로 크기 설정
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/mypage/ranking_bg.png'),
                  fit: BoxFit.fill)),
          child: Padding(
            padding: EdgeInsets.only(top: 0.2 * 0.4 * screenWidth),
            // 이미지 높이의 20%로 패딩 설정
            child: Center(
              child: Text(
                "${widget.rankingNum}번",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 0.05 * screenWidth,
                    fontFamily: 'Nanum'), // 화면 너비의 5%로 폰트 크기 설정
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TriangleItem extends StatefulWidget {
  const TriangleItem({super.key});

  @override
  State<TriangleItem> createState() => TriangleItemState();
}

class TriangleItemState extends State<TriangleItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _triangleController;
  late Animation<double> _triangleAnimation;
  double _triangleTopPosition = 0; // 초기 위치 값 변경

  @override
  void initState() {
    super.initState();
    _triangleController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // initState에서는 MediaQuery.of(context)를 사용할 수 없으므로, 애니메이션 초기화는 나중에 함.
  }

  @override
  void dispose() {
    _triangleController.dispose();
    super.dispose();
  }

  void restartAnimation(double screenHeight) {
    _triangleTopPosition = -0.25 * screenHeight; // 화면 높이의 -25%로 위치 설정
    _triangleAnimation =
        Tween<double>(begin: _triangleTopPosition, end: -0.065 * screenHeight)
            .animate(
      CurvedAnimation(parent: _triangleController, curve: Curves.bounceOut),
    );

    _triangleController.addListener(() {
      setState(() {
        _triangleTopPosition = _triangleAnimation.value;
      });
    });

    _triangleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // 애니메이션이 완료되면 컨트롤러를 정지
        _triangleController.stop();
      }
    });

    _triangleController.reset();
    _triangleController.forward();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; // 화면 크기
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;

    // 애니메이션을 화면 크기 기준으로 시작
    if (_triangleController.status == AnimationStatus.dismissed) {
      restartAnimation(screenHeight);
    }

    return Positioned(
      top: _triangleTopPosition,
      right: 0.1 * screenWidth, // 화면 너비의 10%로 위치 설정
      child: Transform.rotate(
        angle: -pi / 7,
        child: Container(
          width: 0.3 * screenWidth, // 화면 너비의 30%로 크기 설정
          height: 0.3 * screenWidth, // 화면 너비의 30%로 크기 설정
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/mypage/triangle_bg.png'),
                  fit: BoxFit.fill)),
        ),
      ),
    );
  }
}
