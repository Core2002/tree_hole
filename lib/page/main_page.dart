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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
        tooltip: "$_counter",
        child: Transform.rotate(
          angle: -90 * 3.1415926 / 180,
          child: const Icon(CupertinoIcons.battery_full),
        ),
      ),
    );
  }
}
