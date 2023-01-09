import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tree Hole',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '树洞'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Utf8Decoder utf8decoder = const Utf8Decoder();
Future<MESSAGE> getMESSAGE(index) async {
  final response = await http
      .get(Uri.parse('http://192.168.1.3:8080/api/read_index/core/$index'));
  if (response.statusCode == 200) {
    return MESSAGE
        .fromJson(jsonDecode(utf8decoder.convert(response.bodyBytes)));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load MESSAGE');
  }
}

class MESSAGE {
  final String hole;
  final String message;
  final int like;
  final int date;
  final String ip;

  const MESSAGE({
    required this.hole,
    required this.message,
    required this.like,
    required this.date,
    required this.ip,
  });

  // {
  //   "_id": {
  //     "$oid": "63b9ee12872ed97633cbf622"
  //   },
  //   "hole": "core",
  //   "message": "小白は可愛いですね",
  //   "date": {
  //     "$date": {
  //       "$numberLong": "1673129490382"
  //     }
  //   },
  //   "like": 233,
  //   "ip": "127.0.0.1",
  //   "_class": "fun.fifu.server.treehole.pojo.HoleMessage"
  // }
  factory MESSAGE.fromJson(Map<String, dynamic> json) {
    return MESSAGE(
      hole: json['hole'],
      message: json['message'],
      like: json['like'],
      date: json['date'],
      ip: json['ip'],
    );
  }
}

Future<HoleSize> getHoleSize() async {
  final resp = await http
      .get(Uri.parse('http://192.168.1.3:8080/api/read_hole_size/core'));
  return HoleSize.fromJson(jsonDecode(resp.body));
}

class HoleSize {
  final int size;

  const HoleSize({required this.size});

  factory HoleSize.fromJson(Map<String, dynamic> json) {
    return HoleSize(size: json['size']);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var cache = {};

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        toolbarHeight: 36,
      ),
      body: FutureBuilder<HoleSize>(
        future: getHoleSize(),
        builder: (context, snapshot) {
          var size = 0;
          if (snapshot.hasData) {
            size = snapshot.data!.size;
          }

          var listView = ListView.builder(
            itemCount: size + 1,
            itemBuilder: ((context, index) {
              if (!cache.containsKey(index)) {
                cache[index] = getMESSAGE(index);
              }

              var card = FutureBuilder<MESSAGE>(
                future: cache[index],
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: 132,
                      padding: const EdgeInsets.all(18),
                      margin: const EdgeInsets.fromLTRB(18, 6, 18, 6),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 198, 228, 255),
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            offset: Offset(0, 2),
                            color: Colors.blue,
                          )
                        ],
                      ),
                      child: Text(
                        "${snapshot.data!.message}\n赞：${snapshot.data!.like}\nIP地址：${snapshot.data!.ip}",
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              );
              // print("index $index size $size");

              if (index < size) {
                return card;
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: Text(
                      "加载完毕，共 $size 个",
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                );
              }
            }),
          );
          return listView;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
