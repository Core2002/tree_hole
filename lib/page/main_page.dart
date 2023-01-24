import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tree_hole/widget/my_message_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    Navigator.pushNamed(context, "/send_page");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        toolbarHeight: 36,
      ),
      body: const MyMessageList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: "发送",
        child: Transform.rotate(
          angle: -90 * 3.1415926 / 180,
          child: const Icon(CupertinoIcons.battery_full),
        ),
      ),
    );
  }
}
