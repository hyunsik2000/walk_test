import 'package:flutter/material.dart';


class Main1 extends StatefulWidget {
  const Main1({Key? key}) : super(key: key);

  @override
  _Main1State createState() => _Main1State();
}

class _Main1State extends State<Main1> {
  int _selectedIndex = 0; // 선택된 메뉴의 인덱스

  // 각 메뉴에 해당하는 화면을 저장할 리스트
  final List<Widget> _pages = [
    HomeScreen(),
    BoardScreen(),
    UserProfileScreen(),
  ];

  // 메뉴를 선택했을 때 실행되는 콜백 함수
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('일단 메인'),
        ),
        body: _pages[_selectedIndex], // 선택된 메뉴에 해당하는 화면 표시
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: '게시판',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '내 정보',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('홈 화면'),
    );
  }
}

class BoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('게시판 화면'),
    );
  }
}

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('내 정보 화면'),
    );
  }
}
