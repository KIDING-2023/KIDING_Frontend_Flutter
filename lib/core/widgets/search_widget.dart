import 'package:flutter/material.dart';
import 'recommend_games_widget.dart';

class SearchWidget extends StatelessWidget {
  final Size screenSize;

  SearchWidget({required this.screenSize});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
          top: screenSize.height * 0.64,
          child: Container(
            width: screenSize.width,
            child: Column(
              children: <Widget>[
                RecommendGamesWidget(), // 분리된 추천 카드 위젯
              ],
            ),
          ),
        ),
      ],
    );
  }
}
