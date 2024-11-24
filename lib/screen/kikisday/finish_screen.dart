import 'package:flutter/material.dart';
import '../../core/services/game_complete_service.dart';
import '../../core/widgets/finish_screen_widget.dart';
import '../home/home_screen.dart';
import 'set_player_number_screen.dart';

class FinishScreen extends StatefulWidget {
  const FinishScreen({super.key});

  @override
  State<FinishScreen> createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
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

    final message = await _gameService.sendGameCompleteRequest(1, chips);
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
            MaterialPageRoute(builder: (context) => SetPlayerNumberScreen()),
          );
        },
        onHome: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
      ),
    );
  }
}