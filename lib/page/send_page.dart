import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SendPage extends StatefulWidget {
  const SendPage({super.key, required this.title});
  final String title;
  @override
  State<SendPage> createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        toolbarHeight: 36,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          children: [
            TextField(
              autofocus: true,
              maxLength: 150,
              maxLines: 6,
              decoration: InputDecoration(
                labelText: "编辑",
                hintText: "q(≧▽≦q)",
                prefixIcon: Transform.rotate(
                  angle: -90 * 3.1415926 / 180,
                  child: const Icon(CupertinoIcons.battery_full),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 8)),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton.icon(
                icon: const Icon(CupertinoIcons.paperplane_fill),
                label: const Text("发送"),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
