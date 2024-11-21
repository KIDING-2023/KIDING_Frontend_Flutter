import 'package:flutter/material.dart';
import 'package:kiding/screen/kikisday/kikisday_play_screen.dart';
import 'package:kiding/screen/space/space_play_screen.dart';

class RecommendGamesWidget extends StatelessWidget {
  const RecommendGamesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.white.withOpacity(1.0),
              Colors.white.withOpacity(0.0),
              Colors.white.withOpacity(0.0),
              Colors.white.withOpacity(1.0),
            ],
            stops: [0.0, 0.15, 0.85, 1.0],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstOut,
        child: ListView(
          padding: EdgeInsets.only(right: 30),
          scrollDirection: Axis.horizontal,
          children: _buildRecommendCards(context),
        ),
      ),
    );
  }

  List<Widget> _buildRecommendCards(BuildContext context) {
    return [
      _buildRecommendCard(
        context,
        'assets/mypage/favorites_kikisday.png',
        KikisdayPlayScreen(),
      ),
      _buildRecommendCard(
        context,
        'assets/mypage/favorites_space.png',
        SpacePlayScreen(),
      ),
    ];
  }

  Widget _buildRecommendCard(
      BuildContext context, String imagePath, Widget nextScreen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextScreen),
        );
      },
      child: Container(
        width: 230,
        margin: EdgeInsets.only(left: 30),
        child: Stack(
          children: [
            Image.asset(imagePath, fit: BoxFit.cover),
          ],
        ),
      ),
    );
  }
}
