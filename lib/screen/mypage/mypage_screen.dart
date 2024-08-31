import 'dart:math';

import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import '../kikisday/kikisday_play_screen.dart';
import '../space/space_play_screen.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  List<bool> _isFavoriteList = [true, true]; // 각 카드의 즐겨찾기 상태를 관리
  int answerCount = 8; // 대답수 임시
  int ranking = 4; // 순위 임시
  int sameScore = 12; // 동점자수 임시

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
              child: SizedBox()),
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
        // 바디
        body: Stack(
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
                          '대답수 8번',
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
                          '4위',
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
                            '동점자: 12명',
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Nanum',
                                color: Color(0xffff8a5b).withOpacity(0.7)),
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
                                ChipsItem(key: _chipsItemKey),
                                // 친구 수
                                FriendsItem(key: _friendsItemKey),
                                // 1위 경험 횟수
                                RankingItem(key: _rankingItemKey),
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
  const ChipsItem({super.key});

  @override
  State<ChipsItem> createState() => ChipsItemState();
}

class ChipsItemState extends State<ChipsItem>
    with SingleTickerProviderStateMixin {
  int chipsNum = 8; // 키딩칩 수 임시

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
                chipsNum.toString() + "개",
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
  const FriendsItem({super.key});

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
                friendsNum.toString() + "명",
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
  const RankingItem({super.key});

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
                rankingNum.toString() + "번",
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
