import 'package:flutter/material.dart';
import 'package:project123/loginuser/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ㅎㅇ",
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
            home: MyLoginPage(), // MyLoginPage 위젯을 body에 추가
      );
  }
}
