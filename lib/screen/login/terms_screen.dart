import 'package:flutter/material.dart';
import 'package:kiding_frontend/screen/home/home_screen.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60, left: 20),
            child: GestureDetector(
              onTap: Navigator.of(context).pop,
              child: Icon(Icons.arrow_back_ios_new),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Image.asset(
              'assets/login/terms_title.png',
              width: MediaQuery.of(context).size.width - 50 * 2,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 46.26 * 2,
              height: 469.69,
              decoration: ShapeDecoration(
                color: Color(0xFFF5F5F5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: RawScrollbar(
                thumbVisibility: true, // 스크롤바 항상 표시
                thickness: 6.65, // 스크롤바 두께 조절
                radius: Radius.circular(10), // 스크롤바 모서리 둥글게
                thumbColor: Color(0xFFFF6A2A),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical, // 세로 스크롤 설정
                  child: Column(
                    children: [
                      Image.asset('assets/login/terms_detail.png'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 50 * 2,
                height: 49.82,
                decoration: ShapeDecoration(
                  color: Color(0xFFFF6A2A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(29.72),
                  ),
                ),
                child: Center(
                  child: Text(
                    '동의하고 시작하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontFamily: 'Nanum',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
