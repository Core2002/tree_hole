/*
 * Copyright 2023 Core2002
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *           http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pojo/resp_send_message.dart';

class SendPage extends StatefulWidget {
  const SendPage({super.key, required this.title});
  final String title;
  @override
  State<SendPage> createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  String message = "uninit";
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
              onChanged: (value) => message = value,
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
                onPressed: () => sendMessage(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendMessage(BuildContext context) {
    holeSendMessage(message);
    if (message == "uninit") {
      return;
    }
    Navigator.pop(context);
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('已提交'),
          content: Text('信息已提交: $message'),
          actions: [
            TextButton(
              child: const Text('确认'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
