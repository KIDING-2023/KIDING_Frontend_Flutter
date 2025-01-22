import 'package:flutter/material.dart';
import 'package:kiding_frontend/screen/search_screen.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title; // AppBar의 제목
  final Color backgroundColor; // AppBar의 배경색
  final VoidCallback onNotificationTap; // 알림 버튼 클릭 콜백

  const AppBarWidget({
    super.key,
    required this.title,
    required this.backgroundColor,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return AppBar(
      forceMaterialTransparency: true,
      backgroundColor: backgroundColor,
      // 전달받은 배경색 사용
      elevation: 0,
      // AppBar의 그림자 제거
      leading: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10),
        child: IconButton(
          icon: Image.asset(
            'assets/home/notice.png',
            width: 17.08,
            height: 20,
          ),
          onPressed: onNotificationTap,
        ),
      ),
      title: Text(
        title, // 전달받은 제목 사용
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontFamily: 'Nanum',
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 15, top: 10),
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
            width: 40,
            height: screenSize.height * 0.0563,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(27.36),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      color: backgroundColor,
                    ),
                    child: Container(
                      color: Colors.white,
                      child: IconButton(
                        icon: Image.asset(
                          'assets/home/search.png',
                          width: 20.95,
                          height: 20,
                        ),
                        onPressed: () {
                          // 검색 화면으로 이동
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
