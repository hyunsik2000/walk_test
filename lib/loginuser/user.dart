import 'package:flutter/material.dart';
import 'package:project123/loginuser/register.dart';
import 'package:project123/App/main1.dart';

import 'login.dart';

class MyLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyLoginPageState();
  }
}

class MyLoginPageState extends State<MyLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '잠깐 시간 될까',
          style: TextStyle(
            fontFamily: 'Dongle-Bold',
            fontSize: 40,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background1.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => registerUser()),
                  );
                },
                child: Text("회원가입"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => loginUser()),
                  );
                },
                child: Text("로그인"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40),
                ),
              ),
              SizedBox(height: 20), // 로그인 버튼과 정보 버튼 사이의 간격 조절// 로그인 버튼과 정보 버튼 사이의 간격 조절
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Main1()),
                  );
                },
                child: Text("메인"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
