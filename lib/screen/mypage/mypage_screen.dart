import 'dart:math';

import 'package:flutter/material.dart';

import '../home/home_screen.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
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
                'assets/home/menu.png',
                width: 21.65,
                height: 20,
              ),
              onPressed: () {},
            ),
          ),
          title: Text(
            '마이페이지',
            style: TextStyle(
              color: Colors.black, // 텍스트 색상
              fontSize: 18, // 텍스트 크기
              fontFamily: 'Nanum', // 폰트
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
            // 하단바
            Positioned(
                bottom: 75,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 0.1,
                  color: Colors.black,
                )),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Container(
                height: 65,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      icon: Image.asset(
                        'assets/mypage/ranking_unselected.png',
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Image.asset(
                        'assets/mypage/home_unselected.png',
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      },
                    ),
                    IconButton(
                      icon: Image.asset(
                        'assets/mypage/mypage_selected.png',
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            // 바디
            Positioned(
              top: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // 오늘의 랭킹
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Center(
                          child: Container(
                            width: 300.93,
                            height: 117.73,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/mypage/ranking_box_mypage.png'),
                                    fit: BoxFit.fill)),
                            child: Stack(
                              children: [
                                // 대답수
                                Positioned(
                                  top: 56.11,
                                  left: 37.29,
                                  child: Text(
                                    "대답수 " + answerCount.toString() + "번",
                                    style: TextStyle(
                                        color: Color(0xfffad7a0),
                                        fontSize: 25,
                                        fontFamily: 'Nanum'),
                                  ),
                                ),
                                // 순위
                                Positioned(
                                    top: 56.11,
                                    right: 37.29,
                                    child: Text(
                                      ranking.toString() + "위",
                                      style: TextStyle(
                                          color: Color(0xffff8a5b),
                                          fontSize: 25,
                                          fontFamily: 'Nanum'),
                                    )),
                                // 동점자
                                Positioned(
                                  top: 97,
                                  left: 0,
                                  right: 0,
                                  child: Center(
                                    child: Text(
                                      "동점자:" + sameScore.toString() + "명",
                                      style: TextStyle(
                                          color: Color(0xfffad7a0),
                                          fontSize: 12,
                                          fontFamily: 'Nanum'),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      // 나의 기록 텍스트, 새로고침 버튼
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 29.54, right: 29.54),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // 나의 기록 텍스트
                            Image.asset('assets/mypage/my_record_text.png',
                                width: 61, height: 17),
                            // 새로고침 버튼
                            IconButton(
                                onPressed: _restartAnimations,
                                icon: Image.asset('assets/mypage/reset_btn.png',
                                    width: 15.52, height: 15.52))
                          ],
                        ),
                      ),
                      // 나의 기록 박스
                      Center(
                        child: Container(
                            width: 300.93,
                            height: 461.18,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/mypage/my_record_bg.png'),
                                    fit: BoxFit.fill)),
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
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  void _restartAnimations() {
    _chipsItemKey.currentState?.restartAnimation();
    _friendsItemKey.currentState?.restartAnimation();
    _rankingItemKey.currentState?.restartAnimation();
    _triangleItemKey.currentState?.restartAnimation();
  }
}

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
  double _chipsTopPosition = -252;

  @override
  void initState() {
    super.initState();
    _chipsController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

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

    _startAnimation();
  }

  @override
  void dispose() {
    _chipsController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _chipsController.reset();
    _chipsController.forward();
  }

  void restartAnimation() {
    _startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _chipsTopPosition,
      left: 22,
      child: Transform.rotate(
        angle: pi / 7,
        child: Container(
          width: 184.63,
          height: 184.63,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/mypage/chips_bg.png'),
                  fit: BoxFit.fill)),
          child: Padding(
            padding: const EdgeInsets.only(top: 53.06),
            child: Center(
              child: Text(
                chipsNum.toString() + "개",
                style: TextStyle(
                    color: Colors.white, fontSize: 30, fontFamily: 'Nanum'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
  double _friendsTopPosition = -100;

  @override
  void initState() {
    super.initState();
    _friendsController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

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

    _startAnimation();
  }

  @override
  void dispose() {
    _friendsController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _friendsController.reset();
    _friendsController.forward();
  }

  void restartAnimation() {
    _startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _friendsTopPosition,
      right: 0,
      child: Transform.rotate(
        angle: -pi / 7,
        child: Container(
          width: 180.19,
          height: 180.19,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/mypage/friends_bg.png'),
                  fit: BoxFit.fill)),
          child: Padding(
            padding: const EdgeInsets.only(top: 45),
            child: Center(
              child: Text(
                friendsNum.toString() + "명",
                style: TextStyle(
                    color: Colors.white, fontSize: 25, fontFamily: 'Nanum'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
  double _rankingTopPosition = -50;

  @override
  void initState() {
    super.initState();
    _rankingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

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

    _startAnimation();
  }

  @override
  void dispose() {
    _rankingController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _rankingController.reset();
    _rankingController.forward();
  }

  void restartAnimation() {
    _startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _rankingTopPosition,
      left: -8,
      child: Transform.rotate(
        angle: -pi / 20,
        child: Container(
          width: 152.28,
          height: 152.28,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/mypage/ranking_bg.png'),
                  fit: BoxFit.fill)),
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
              child: Text(
                rankingNum.toString() + "번",
                style: TextStyle(
                    color: Colors.white, fontSize: 20, fontFamily: 'Nanum'),
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
  double _triangleTopPosition = -200;

  @override
  void initState() {
    super.initState();
    _triangleController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _triangleAnimation =
        Tween<double>(begin: _triangleTopPosition, end: -65).animate(
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

    _startAnimation();
  }

  @override
  void dispose() {
    _triangleController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _triangleController.reset();
    _triangleController.forward();
  }

  void restartAnimation() {
    _startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _triangleTopPosition,
      right: 40,
      child: Transform.rotate(
        angle: -pi / 7,
        child: Container(
          width: 121.06,
          height: 121.06,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/mypage/triangle_bg.png'),
                  fit: BoxFit.fill)),
        ),
      ),
    );
  }
}
