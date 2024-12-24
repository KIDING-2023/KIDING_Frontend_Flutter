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
          width: ScreenWidth * 0.8332,
          height: ScreenHeight * 0.2253,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset(
                      'assets/ranking/friends_cancel_btn.png',
                      width: ScreenWidth * 0.37,
                      height: ScreenHeight * 0.033,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/ranking/friends_send_btn.png',
                      width: ScreenWidth * 0.37,
                      height: ScreenHeight * 0.033,
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
