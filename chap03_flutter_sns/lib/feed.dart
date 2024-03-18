import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  const Feed({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  // 좋아요
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          widget.imageUrl,
          // 'https://gratisography.com/wp-content/uploads/2024/01/gratisography-cyber-kitty-1170x780.jpg',
          height: 400,
          // 위젯의 너비를 디바이스에 맞게 최대로 설정
          width: double.infinity,
          // 전체 프레임을 채우기 위해 사진을 확대하거나 축소
          // 사진이 프레임보다 작아도 사진의 모양을 유지하면서 프레임의 모든 공간을 채우는 설정
          fit: BoxFit.cover,
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              icon: Icon(
                CupertinoIcons.heart,
                color: isFavorite ? Colors.red : Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.chat_bubble,
                color: Colors.black,
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.bookmark,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Padding(
          // 좋아요
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '3 likes',
            style: TextStyle(
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Padding(
          /// 피드 글
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '네온과 고양이, 최고의 조합 😎 \n#CatLife #NeonVibes',
            style: TextStyle(
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Padding(
          // 날짜
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'March 6',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}