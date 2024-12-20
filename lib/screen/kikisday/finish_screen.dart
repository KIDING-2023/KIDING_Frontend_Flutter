import 'package:flutter/material.dart';
import 'package:kiding_frontend/core/services/game_complete_service.dart';
import 'package:kiding_frontend/core/widgets/finish_screen_widget.dart';
import 'package:kiding_frontend/screen/home/home_screen.dart';
import 'package:kiding_frontend/screen/kikisday/set_player_number_screen.dart';

class FinishScreen extends StatefulWidget {
  const FinishScreen({super.key});

  @override
  State<FinishScreen> createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  final GameService _gameService = GameService();
  late int chips; // chips 변수를 상태로 관리

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 전달된 인자를 안전하게 가져오기
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    chips = arguments['chips'];
    _sendGameCompleteRequest(); // 안전한 시점에 서버 요청
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _sendGameCompleteRequest(); // 화면이 로드될 때 서버 요청
  // }

  Future<void> _sendGameCompleteRequest() async {
    final message = await _gameService.sendGameCompleteRequest(1, chips);
    print(message); // 요청 결과 출력
  }

  // Future<void> _sendGameCompleteRequest() async {
  //   // 전달된 인자를 받기
  //   final arguments = ModalRoute.of(context)!.settings.arguments as Map;
  //   int chips = arguments['chips'];

  //   final message = await _gameService.sendGameCompleteRequest(1, chips);
  //   print(message); // 요청 결과 출력
  // }

  @override
  Widget build(BuildContext context) {
    // // 전달된 인자를 받기
    // final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    // int chips = arguments['chips'];

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
        bg: 'assets/kikisday/kikisday_finish_bg.png',
      ),
    );
  }
}
