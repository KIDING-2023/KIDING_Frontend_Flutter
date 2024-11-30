import 'package:flutter/material.dart';
import 'package:kiding/screen/space/space_set_player_number_screen.dart';
import '../../core/services/game_complete_service.dart';
import '../../core/widgets/finish_screen_widget.dart';
import '../home/home_screen.dart';

class SpaceFinishScreen extends StatefulWidget {
  const SpaceFinishScreen({super.key});

  @override
  State<SpaceFinishScreen> createState() => _SpaceFinishScreenState();
}

class _SpaceFinishScreenState extends State<SpaceFinishScreen> {
  final GameService _gameService = GameService();

  @override
  void initState() {
    super.initState();
    _sendGameCompleteRequest(); // 화면이 로드될 때 서버 요청
  }

  Future<void> _sendGameCompleteRequest() async {
    // 전달된 인자를 받기
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    int chips = arguments['chips'];

    final message = await _gameService.sendGameCompleteRequest(2, chips);
    print(message); // 요청 결과 출력
  }

  @override
  Widget build(BuildContext context) {
    // 전달된 인자를 받기
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    int chips = arguments['chips'];

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: FinishScreenBody(
        chips: chips,
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        onReplay: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SpaceSetPlayerNumberScreen()),
          );
        },
        onHome: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
        bg: 'assets/space/space_finish_bg.png',
      ),
    );
  }
}
