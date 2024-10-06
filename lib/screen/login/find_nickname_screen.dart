import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kiding/screen/login/start_screen.dart';
import 'nickname_phone_screen.dart';

// 닉네임 찾기 - 전화번호 입력 화면
class FindNicknameScreen extends StatefulWidget {
  const FindNicknameScreen({super.key});

  @override
  State<FindNicknameScreen> createState() => _FindNicknameScreenState();
}

class _FindNicknameScreenState extends State<FindNicknameScreen> {
  final _phoneController = TextEditingController(); // 전화번호 입력 컨트롤러
  bool errorVisible = false; // 에러 메시지 가시성
  String errorMessage = ""; // 에러 메시지

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size; // 기기 화면 크기
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Stack(
        children: [
          // 뒤로가기 버튼
          Positioned(
            top: screenSize.height * 0.06,
            left: screenSize.width * 0.03,
            child: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StartScreen()));
              },
              icon: Image.asset('assets/kikisday/back_icon.png',
                  width: screenSize.width * 0.04,
                  height: screenSize.height * 0.03),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // '닉네임 찾기' 텍스트
              Image.asset('assets/login/find_nickname_text.png',
                  width: screenSize.width * 0.74,
                  height: screenSize.height * 0.11),
              // 전화번호 입력칸, 닉네임 찾기 버튼
              Column(
                // 전화번호 입력칸
                children: [
                  Container(
                    width: screenSize.width * 0.73,
                    height: screenSize.height * 0.06,
                    child: TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                          hintText: '전화번호를 입력하세요',
                          hintStyle: TextStyle(color: Color(0xFFAAAAAA)),
                          filled: true,
                          fillColor: Color(0xfff6f6f6),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(100)),
                          contentPadding: EdgeInsets.all(20)),
                      style: TextStyle(
                        fontFamily: 'nanum',
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  // 전화번호 오류 메시지
                  Row(
                    children: [
                      Padding(
                          padding:
                              EdgeInsets.only(left: screenSize.width * 0.21)),
                      Visibility(
                        visible: errorVisible,
                        child: Icon(
                          Icons.circle,
                          size: screenSize.width * 0.01,
                          fill: 1.0,
                          color: Color(0xFFFFA37C),
                        ),
                      ),
                      Padding(
                          padding:
                              EdgeInsets.only(left: screenSize.width * 0.01)),
                      Text(
                        errorMessage,
                        style: TextStyle(
                            fontFamily: 'nanum',
                            fontSize: 13,
                            color: Color(0xFFFFA37C)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenSize.height * 0.01,
                  ),
                  // 닉네임 찾기 버튼
                  IconButton(
                    onPressed: _findNickname,
                    padding: EdgeInsets.zero,
                    icon: Image.asset('assets/login/find_nickname_btn.png',
                        width: screenSize.width * 0.73),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ));
  }

  // 닉네임 찾기 로직 추가 필요
  void _findNickname() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NicknamePhoneScreen(
                nickname: "닉네임",
                phone: _phoneController.text.replaceFirst('0', '+82'))));
  }

// 닉네임 찾기 (파이어베이스)
// void _findNickname() async {
//   final DatabaseReference dbRef = FirebaseDatabase.instance.ref('users');
//   final String phone = _phoneController.text;
//
//   DataSnapshot snapshot = await dbRef.child(phone).get();
//
//   if (snapshot.exists && snapshot.value != null) {
//     try {
//       // snapshot.value를 안전하게 Map으로 변환
//       Map<dynamic, dynamic> userData =
//           snapshot.value as Map<dynamic, dynamic>;
//       String nickname = userData['nickname'] as String; // 닉네임 추출
//       setState(() {
//         errorVisible = false;
//         errorMessage = '';
//       });
//       print('찾은 닉네임: $nickname');
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => NicknamePhoneScreen(
//                   nickname: nickname,
//                   phone: _phoneController.text.replaceFirst('0', '+82'))));
//     } catch (e) {
//       // 타입 변환 실패 시
//       print('Data type conversion error: $e');
//       setState(() {
//         errorVisible = true;
//         errorMessage = '데이터 형식 오류';
//       });
//     }
//   } else {
//     setState(() {
//       errorVisible = true;
//       errorMessage = '없는 전화번호입니다.';
//     });
//   }
// }
}
