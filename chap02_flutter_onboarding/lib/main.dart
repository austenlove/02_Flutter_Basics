import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // backgroundColor: Color.fromARGB(255, 36, 34, 34),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TestScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TestScreen extends StatelessWidget {
  final List<Introduction> list = [
    Introduction(
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 32,
      ),
      title: '현재의 나',
      subTitle: '열심히 일하는 초보 직장인',
      imageUrl: 'assets/images/1.png',
    ),
    Introduction(
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 32,
      ),
      title: '수료 후의 나',
      subTitle: '사고를 많이 칠 것 같은 신난 표정',
      imageUrl: 'assets/images/2.png',
    ),
    Introduction(
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 32,
      ),
      title: '10년 후의 나',
      subTitle: '회사에 오래 다니고 싶어요.',
      imageUrl: 'assets/images/3.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroScreenOnboarding(
      introductionList: list,
      onTapSkipButton: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      },
      backgroudColor: Colors.yellow,
      foregroundColor: Colors.blue,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,
      ),
      backgroundColor: Colors.blue,
      body: Center(
        child: Text(
          '챈님 자기소개 어플 테스트',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
