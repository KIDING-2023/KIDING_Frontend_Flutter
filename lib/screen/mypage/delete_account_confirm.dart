import 'package:flutter/material.dart';

class DeleteAccountConfirm extends StatelessWidget {
  const DeleteAccountConfirm({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 86, 93, 108),
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
                image: const AssetImage('assets/ranking/friends_icon.png'),
                width: screenWidth * 0.1819,
              ),
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  '본인 계정을 탈퇴하고\n키딩북을 떠나시겠습니까?',
                  style: const TextStyle(
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
                        color: const Color(0xFF838383),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.38),
                        ),
                      ),
                      child: const Center(
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
                    onTap: () {}, // 계정 탈퇴 로직 추가
                    child: Container(
                      width: 136.71,
                      height: 26.76,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFF8A5B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.38),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '탈퇴하기',
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
