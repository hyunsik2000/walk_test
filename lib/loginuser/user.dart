import 'dart:convert';
import 'dart:core';


import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:flutter/material.dart';
import 'package:project123/loginuser/register.dart';
import 'package:project123/App/main1.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'login.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

final storage = FlutterSecureStorage();

class MyLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyLoginPageState();
  }
}

Future<bool> kakaoLogingUsers(
    String code, BuildContext context) async {
  try {
    var Url = Uri.parse("http://192.168.56.1:8080/auth/kakao"); //본인 IP 주소를  localhost 대신 넣기
    var response = await http.post(Url,
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "authorizationcode": code,
        }));
    print(response);
    if (response.statusCode == 200) {
      // 로그인 성공 시
      final Map<String, dynamic> responseData = jsonDecode(utf8.decode(response.bodyBytes));
      final String accessToken = responseData['accessToken'];
      final int accessTokenExpireIn = responseData['accessTokenExpireIn'];

      await storage.write(key: 'accessToken', value: accessToken);
      await storage.write(key: 'accessTokenExpireIn', value: accessTokenExpireIn.toString());

      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext dialogContext) {
          return MyAlertDialog(
            title: '처리 메시지',
            content: '로그인에 성공하였습니다',
          );
        },
      ).then((_) {
        // 대화 상자가 닫힌 후에 실행될 코드
        Navigator.push(context, MaterialPageRoute(builder: (context) => Main1()));
      });
      return true;
    } else if (response.statusCode == 400) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext dialogContext) {
            return MyAlertDialog(title: '오류 메시지',
                content:'로그인 실패');
          });
      return false;
    }
  } catch (e) {
    print('서버 연결 오류: $e');
    // 서버 연결 오류를 처리할 수 있는 코드를 추가하십시오.
    throw Exception('서버 연결 오류: $e');
  }
  return false;
}

class MyLoginPageState extends State<MyLoginPage>{
  late String authCode;

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
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('카카오톡으로 로그인'),
                onPressed: () async {
                    try {
                      await UserApi.instance.loginWithKakaoAccount();
                      print('카카오톡으로 로그인 성공');
                    } catch (error) {
                      print('카카오톡으로 로그인 실패 $error');
                      // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
                      // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
                    }
                    // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                    try {
                      await UserApi.instance.loginWithKakaoAccount();
                      print('카카오계정으로 로그인 성공');
                    } catch (error) {
                      print('카카오계정으로 로그인 실패 $error');
                    }
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _launchKakaoLoginUrl() async {
  try {
    final url = 'https://kauth.kakao.com/oauth/authorize?client_id=a0120cb04bb109d4e2a6ad0a2ea8f24d&redirect_uri=http://localhost:8080/kakao/callback&response_type=code';
    if (await url_launcher.canLaunch(url)) {
      await url_launcher.launch(url);
      print("1단계 성공");
    } else {
      print('URL을 열 수 없습니다.');
    }
  } catch (e) {
    print('카카오 로그인 실패: $e');
  }
}

class MyAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  MyAlertDialog({
    required this.title,
    required this.content,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        this.title,
        style: TextStyle(
          // 제목 텍스트 스타일을 직접 지정
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: this.actions,
      content: Text(
        this.content,
        style: TextStyle(
          // 내용 텍스트 스타일을 직접 지정
          fontSize: 16.0,
        ),
      ),
    );
  }
}