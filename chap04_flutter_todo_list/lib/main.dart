import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


// 상태 클래스
class _HomePageState extends State<HomePage> {

  List<ToDo> toDoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'ListView, ListTile 연습',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: toDoList.isEmpty
          ? Center(child: Text('ToDo List를 작성해주세요.'),)
          : ListView.builder(
            itemCount: toDoList.length,
            itemBuilder: (context, index) {
              ToDo toDo = toDoList[index];
              
              return ListTile(
                title: Text(
                    toDo.toDo,
                    style: TextStyle(
                      fontSize: 20,
                      color: toDo.isDone ? Colors.grey : Colors.black,
                      decoration: toDo.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('삭제하시겠습니까?'),
                            actions: [
                              // 취소 버튼
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  '취소',
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              // 삭제 버튼
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    toDoList.removeAt(index);
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  '삭제',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            ],
                          );
                        });
                  },
                  icon: Icon(CupertinoIcons.delete)),
                onTap: () {
                  // 아이템 클릭 시
                  setState(() {
                    toDo.isDone = !toDo.isDone;
                  });
                },
              );
          },
      ),

      floatingActionButton: FloatingActionButton(
        // toDo 받아오기
        onPressed: () async {
          String? toDo = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CreatePage()),
          );

          if(toDo != null) {
            setState(() {
              ToDo newToDo = ToDo(toDo, false);
              toDoList.add(newToDo);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  // 텍스트 필드의 값을 가져올 때 사용
  TextEditingController textEditingController = TextEditingController();

  // 경고 메시지
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {
            // 이전 페이지로 이동
            Navigator.pop(context);
          },
          icon: Icon(CupertinoIcons.chevron_back),
        ),
        title: Text(
          'Todo List 작성 페이지',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // 텍스트 입력창
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textEditingController,
              // 화면이 뜰 때 입력창에 커서가 바로 오게 하는 기능
              autofocus: true,
              decoration: InputDecoration(
                  hintText: '할 일을 입력하세요',
                  errorText: error,
              ),
            ),
          ),

          // TextField와 ElevatedButton 사이에 공간
          SizedBox(
            height: 16,
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            // SizedBox : child widget의 size를 강제할 때 사용
            child: SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  // 추가하기 버튼 클릭 시 작동
                  String toDo = textEditingController.text;

                  if(toDo.isEmpty) {
                    setState(() {
                      error = "내용을 입력해주세요.";
                    });
                  } else {
                    setState(() {
                      error = null;
                    });
                  }
                  Navigator.pop(context, toDo);
                },
                child: Text(
                  '추가하기',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ToDo 클래스
class ToDo {
  String toDo;
  bool isDone;

  ToDo(this.toDo, this.isDone);
}