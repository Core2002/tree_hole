import 'package:flutter/material.dart';
import 'package:tree_hole/page/main_page.dart';

import 'page/send_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tree Hole',
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: {
        "/": (context) => const MyHomePage(title: '树洞'),
        "/send_page":(context) => const SendPage(title: '发布'),
      },
    );
  }
}
