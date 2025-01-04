import 'dart:convert';

import 'package:flutter/material.dart';

class RankingFriendsScreen extends StatefulWidget {
  final String name;

  const RankingFriendsScreen({super.key, required this.name});

  @override
  State<RankingFriendsScreen> createState() => _RankingFriendsScreenState();
}

class _RankingFriendsScreenState extends State<RankingFriendsScreen> {
  @override
  Widget build(BuildContext context) {
    double ScreenWidth = MediaQuery.of(context).size.width;
    double ScreenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 86, 93, 108),
      body: Center(
        child: Container(
          width: 300,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image(
                image: AssetImage(
                  'assets/ranking/friends_icon.png',
                ),
                width: ScreenWidth * 0.1819,
              ),
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  "'${widget.name}' 친구에게\n친구 신청을 보내시겠습니까?",
                  style: TextStyle(
                    fontFamily: 'Nanum',
                    fontSize: 15,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 136.71,
                      height: 26.76,
                      decoration: ShapeDecoration(
                        color: Color(0xFF838383),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.38),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '취소',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Nanum',
                            fontWeight: FontWeight.w800,
                            height: 1.40,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 136.71,
                      height: 26.76,
                      decoration: ShapeDecoration(
                        color: Color(0xFFFF8A5B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.38),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '보내기',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Nanum',
                            fontWeight: FontWeight.w800,
                            height: 1.40,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
