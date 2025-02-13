import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kiding_frontend/core/constants/api_constants.dart';
import 'package:kiding_frontend/core/widgets/recommend_games_widget.dart';

import 'package:http/http.dart' as http;
import 'package:kiding_frontend/screen/kikisday/kikisday_play_screen.dart';
import 'package:kiding_frontend/screen/ranking/ranking_friends_screen.dart';
import 'package:kiding_frontend/screen/space/space_play_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  bool hasSearched = false; // 검색 여부

  String searchWord = ''; // 검색어

  List<String> recentSearchWords = []; // 최근 검색어 리스트 (임시)

  List<dynamic> searchResult = []; // 검색 결과 리스트

  final storage = FlutterSecureStorage(); // Secure Storage 인스턴스 생성

  // 서버에서 검색 결과 가져오기
  Future<void> fetchSearchData() async {
    String? token = await storage.read(key: 'accessToken');

    debugPrint("AccessToken: $token");

    var url = Uri.parse('${ApiConstants.baseUrl}/search?word=$searchWord');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);
      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}'); // 서버로부터 받은 응답 로그 출력

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['isSuccess']) {
          // 응답이 성공일 경우 데이터 업데이트
          if (data['message'] != '검색어에 해당되는 데이터가 없습니다.') {
            setState(() {
              searchResult = data['result'];
            });
          } else {
            setState(() {
              searchResult = [];
            });
          }
        } else {
          setState(() {
            debugPrint(data['message']);
          });
        }
      } else {
        setState(() {
          debugPrint("서버 오류: ${response.statusCode}");
        });
      }
    } catch (e) {
      setState(() {
        debugPrint("네트워크 오류: $e");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    updateRecentSearchWords();
  }

  Future<void> updateRecentSearchWords() async {
    List<String> recentWords = await getRecentSearchWords();
    setState(() {
      recentSearchWords = recentWords;
    });
  }

  Future<void> addSearchWord(String word) async {
    // 기존 검색어 가져오기
    String? existingData = await storage.read(key: 'recentSearchWords');
    List<String> searchWords = existingData != null
        ? (jsonDecode(existingData) as List<dynamic>).cast<String>()
        : [];

    // 중복 방지 및 새 검색어 추가
    if (!searchWords.contains(word)) {
      searchWords.insert(0, word);
      if (searchWords.length > 10) {
        // 최대 10개까지만 저장
        searchWords.removeLast();
      }

      // 저장
      await storage.write(
          key: 'recentSearchWords', value: jsonEncode(searchWords));
    }
  }

  Future<List<String>> getRecentSearchWords() async {
    String? existingData = await storage.read(key: 'recentSearchWords');
    return existingData != null
        ? (jsonDecode(existingData) as List<dynamic>).cast<String>()
        : [];
  }

  Future<void> clearRecentSearchWords() async {
    await storage.delete(key: 'recentSearchWords');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          // 검색창 부분
          Column(
            children: [
              // 검색창
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 뒤로 가기 버튼
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_back_ios_new),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Container(
                      width: 300.w,
                      height: 45.h,
                      decoration: ShapeDecoration(
                        color: Color(0xFFFF8A5B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27.36),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 230.w,
                              child: TextField(
                                controller: searchController,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.22.sp,
                                  fontFamily: 'Nanum',
                                  fontWeight: FontWeight.w800,
                                ),
                                decoration: InputDecoration(
                                  hintText: '검색어를 입력하세요',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.22.sp,
                                    fontFamily: 'Nanum',
                                    fontWeight: FontWeight.w800,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            // 검색 버튼
                            GestureDetector(
                              onTap: () async {
                                setState(() {
                                  searchWord = searchController.text;
                                  hasSearched = true; // 검색 상태 업데이트
                                });
                                await addSearchWord(searchWord); // 검색 기록 저장
                                fetchSearchData(); // 검색 API 호출
                                updateRecentSearchWords(); // UI 업데이트
                              },
                              child: Image.asset(
                                'assets/home/search_icon_selected.png',
                                width: 20.w,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/search/search_user_text.png',
                      width: 92.w,
                    ),
                    SizedBox(
                      width: 30.w,
                    ),
                    Image.asset(
                      'assets/search/search_game_text.png',
                      width: 116.w,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35.h,
              ),
              // 최근 검색어
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '최근 검색어',
                          style: TextStyle(
                            color: Color(0xFF858585),
                            fontSize: 14.22.sp,
                            fontFamily: 'Nanum',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await clearRecentSearchWords(); // 저장된 검색 기록 삭제
                            updateRecentSearchWords(); // UI 업데이트
                          },
                          child: Text(
                            '전체삭제',
                            style: TextStyle(
                              color: Color(0xFF858585),
                              fontSize: 12.22.sp,
                              fontFamily: 'Nanum',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 최근 검색어 리스트
                  Padding(
                    padding: EdgeInsets.only(top: 10.h, left: 30.w),
                    child: SizedBox(
                      height: 30.h,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                          recentSearchWords.length,
                          (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                // 검색창에 값 설정
                                searchController.text =
                                    recentSearchWords[index];
                                searchWord = recentSearchWords[index];
                                hasSearched = true;
                              });
                              fetchSearchData(); // 검색 함수 호출
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: Container(
                                height: 29.26.h,
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1.02.w,
                                        color: Color(0xFFFF8A5B)),
                                    borderRadius: BorderRadius.circular(27.99),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    recentSearchWords[index],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFFFF8A5B),
                                      fontSize: 14.55.sp,
                                      fontFamily: 'Nanum',
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          if (hasSearched) ...[
            // 친구
            Padding(
              padding: EdgeInsets.only(left: 30.w, top: 30.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '친구',
                    style: TextStyle(
                      color: Color(0xFF858585),
                      fontSize: 14.22.sp,
                      fontFamily: 'Nanum',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  // 친구 검색 결과 리스트
                  searchResult
                          .where(
                              (result) => result['entityTypeValue'] == 'USER')
                          .toList()
                          .isEmpty
                      ? Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: Text(
                            '검색어와 일치하는 유저가 없습니다.',
                            style: TextStyle(
                              color: Color.fromARGB(255, 187, 187, 187),
                              fontSize: 14.22.sp,
                              fontFamily: 'Nanum',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: SizedBox(
                            height: 100.h, // 이미지 높이를 고려한 적절한 크기 설정
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: searchResult
                                  .where((result) =>
                                      result['entityTypeValue'] == 'USER')
                                  .length,
                              itemBuilder: (context, index) {
                                // USER 필터링된 리스트 생성
                                final userList = searchResult
                                    .where((result) =>
                                        result['entityTypeValue'] == 'USER')
                                    .toList();
                                final user = userList[index];
                                return Padding(
                                  padding: EdgeInsets.only(right: 10.w),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RankingFriendsScreen(
                                            name: user['name'],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        // 친구 이미지
                                        user['image'] == null
                                            ? CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    'assets/ranking/small_icon_1.png'),
                                                radius: 35, // 원형 이미지 크기
                                              )
                                            : CircleAvatar(
                                                backgroundImage:
                                                    NetworkImage(user['image']),
                                                radius: 35, // 원형 이미지 크기
                                              ),
                                        SizedBox(height: 5.h),
                                        // 친구 이름
                                        Text(
                                          user['name'],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.sp,
                                            fontFamily: 'Nanum',
                                            fontWeight: FontWeight.w800,
                                            height: 1.12.h,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                ],
              ),
            ),
            // 게임
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30.w, top: 30.h),
                  child: Text(
                    '게임',
                    style: TextStyle(
                      color: Color(0xFF858585),
                      fontSize: 14.22.sp,
                      fontFamily: 'Nanum',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                // 게임 검색 결과 리스트
                searchResult
                        .where((result) =>
                            result['entityTypeValue'] == 'BOARD_GAME')
                        .toList()
                        .isEmpty
                    ? Padding(
                        padding: EdgeInsets.only(top: 10.h, left: 30.w),
                        child: Text(
                          '검색어와 일치하는 게임이 없습니다.',
                          style: TextStyle(
                            color: Color.fromARGB(255, 187, 187, 187),
                            fontSize: 14.22.sp,
                            fontFamily: 'Nanum',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(top: 10.h, left: 30.w),
                        child: SizedBox(
                          height: 100.h, // 이미지 높이를 고려한 적절한 크기 설정
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: searchResult
                                .where((result) =>
                                    result['entityTypeValue'] == 'BOARD_GAME')
                                .length,
                            itemBuilder: (context, index) {
                              // BOARD_GAME 필터링된 리스트 생성
                              final gameList = searchResult
                                  .where((result) =>
                                      result['entityTypeValue'] == 'BOARD_GAME')
                                  .toList();
                              return Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: Row(
                                  children: [
                                    gameList.any(
                                            (game) => game['name'] == '키키의 하루')
                                        ? GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      KikisdayPlayScreen(),
                                                ),
                                              );
                                            },
                                            child: SizedBox(
                                              width: 230.w,
                                              child: Stack(
                                                children: <Widget>[
                                                  Image.asset(
                                                      'assets/mypage/favorites_kikisday.png',
                                                      fit: BoxFit.cover),
                                                ],
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                    gameList.any((game) =>
                                            game['name'] == '키키의 우주여행')
                                        ? GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SpacePlayScreen(),
                                                ),
                                              );
                                            },
                                            child: SizedBox(
                                              width: 230.w,
                                              child: Stack(
                                                children: <Widget>[
                                                  Image.asset(
                                                      'assets/mypage/favorites_space.png',
                                                      fit: BoxFit.cover),
                                                ],
                                              ),
                                            ),
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
              ],
            ),
          ],
          // 추천 게임 부분
          Padding(
            padding: EdgeInsets.only(top: 30.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
                  child: Text(
                    '추천 게임',
                    style: TextStyle(
                      fontFamily: 'Nanum',
                      fontSize: 14.22.sp,
                      color: Color(0xff868686),
                    ),
                  ),
                ),
                // 추천 카드덱 리스트
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      RecommendGamesWidget(), // 분리된 추천 카드 위젯
                    ],
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
