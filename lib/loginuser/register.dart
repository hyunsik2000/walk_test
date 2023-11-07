import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import "package:project123/Model/UserModel.dart";
import 'package:http/http.dart' as http;

class registerUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return registerUserState();
  }
}

Future<bool> registerUsers(
    String email, String password, String nickname, String name, BuildContext context) async {
  try {
        var Url = Uri.parse("http://local:8080/auth/register"); //본인 IP 주소를  localhost 대신 넣기
    var response = await http.post(Url,
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "email": email,
          "password": password,
          "nickname": nickname,
          "name": name,
        }));
    print(response);
    if (response.statusCode == 200) {
      String responseString = response.body;
      // 이 부분에서 서버 응답을 확인하고 true를 반환하도록 처리
      if (responseString == 'true') {
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext dialogContext) {
              return MyAlertDialog(title: '처리 메시지',
                  content: '회원가입이 완료되었습니다');
            });
        return true;
      }
    } else if (response.statusCode == 400 || response.statusCode == 409) {
      final Map<String, dynamic> errorResponse = jsonDecode(utf8.decode(response.bodyBytes));
      final errorMessage = errorResponse["message"];
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext dialogContext) {
            return MyAlertDialog(title: '오류 메시지',
                content: errorMessage);
          });
    }
    // 모든 경우에 대한 반환값을 추가
    return false;
  } catch (e) {
    print('서버 연결 오류: $e');
    // 서버 연결 오류를 처리할 수 있는 코드를 추가하십시오.
    throw Exception('서버 연결 오류: $e');
  }
}





class registerUserState extends State<registerUser> {
  final minimumPadding = 5.0;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontSize: 16.0, // 원하는 폰트 크기로 설정
      fontWeight: FontWeight.normal, // 원하는 폰트 두께로 설정
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("회원 갱신"),
      ),
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(minimumPadding * 2),
          child: ListView(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: emailController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return '땡';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'email',
                        hintText: '작성해주세요',
                        labelStyle: textStyle,
                        border: OutlineInputBorder (
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: passwordController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return '땡';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: '비밀번호',
                        hintText: '작성해주세요',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: nicknameController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return '땡';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: '닉네임',
                        hintText: '작성해주세요',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: minimumPadding, bottom: minimumPadding),
                  child: TextFormField(
                    style: textStyle,
                    controller: nameController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return '땡';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: '이름',
                        hintText: '작성해주세요',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
        ElevatedButton(
          child: Text('작성'),
          onPressed: () async {
            String email = emailController.text;
            String password = passwordController.text;
            String nickname = nicknameController.text;
            String name = nameController.text;

            try {
              bool registrationResult = await registerUsers(email, password, nickname, name, context);

              if (registrationResult) {
                // 회원 등록 성공
                print('회원 등록 성공');

                // 이후 사용자 정보를 가져오는 요청 또는 다른 작업을 수행
                // UserModel userModel = await fetchUserInfo(email);
              } else {
                // 회원 등록 실패
                print('회원 등록 실패');
                // 다른 처리 수행
              }
            } catch (e) {
              print('서버 연결 오류: $e');
              // 서버 연결 오류를 처리
            }
          },
        )
        ],
          ),
        ),
      ),
    );
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