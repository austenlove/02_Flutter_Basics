import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Shared_preferences 인스턴스를 어디서든 접근 가능하도록 전역 변수로 선언
// late : 나중에 꼭 값을 할당해준다는 의미
late SharedPreferences prefs;

Future<void> main() async {
  // main() 함수에서 async 쓰러면 필요
  WidgetsFlutterBinding.ensureInitialized();

  // Shared_preferences 인스턴스 생성
  prefs = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SharedPreference에서 온보딩 완료 여부 조회
    // isOnboardec에 해당하는 값에서 null을 반환하는 경우 false를 기본값으로 지정
    bool isOnboarded = prefs.getBool('isOnboarded') ?? false;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'NotoSansKr',
        primarySwatch: Colors.blue,
        // backgroundColor: Color.fromARGB(255, 36, 34, 34),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: isOnboarded ? HomePage() : TestScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TestScreen extends StatelessWidget {
  final List<Introduction> list = [
    Introduction(
      titleTextStyle: TextStyle(
        fontSize: 32,
        fontFamily: 'NotoSansKR',
        fontWeight: FontWeight.w700,
      ),
      title: '현재의 나',
      subTitle: '열심히 일하는 초보 직장인',
      imageUrl: 'assets/images/1.png',
    ),
    Introduction(
      titleTextStyle: TextStyle(
        fontSize: 32,
        fontFamily: 'NotoSansKR',
        fontWeight: FontWeight.w700,
      ),
      title: '수료 후의 나',
      subTitle: '어쩐지 사고를 많이 칠 것 같은 표정',
      imageUrl: 'assets/images/2.png',
    ),
    Introduction(
      titleTextStyle: TextStyle(
        fontSize: 32,
        fontFamily: 'NotoSansKR',
        fontWeight: FontWeight.w700,
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
        // 마지막 페이지가 나오거나 skip해서 Homepage로 가기 전에 isOnboarded를 true로 바꿈
        prefs.setBool('isOnboarded', true);
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
        actions: [
          IconButton(onPressed: () {prefs.clear();}, icon: Icon(Icons.delete)),
        ],
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
