import 'package:flutter/material.dart';
import 'package:project123/loginuser/user.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

void main() {
  KakaoSdk.init(nativeAppKey: '3c742c2ebf383767000fafabfb006f7f');
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
