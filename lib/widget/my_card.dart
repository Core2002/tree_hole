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
import 'package:intl/intl.dart';
import 'package:tree_hole/pojo/hole_like.dart';
import 'package:tree_hole/pojo/hole_message.dart';

import '../pojo/hole_report.dart';

class MyCard extends StatefulWidget {
  const MyCard({super.key, required this.holeMessage, required this.onRemove});
  final HoleMessage holeMessage;
  final void Function() onRemove;

  @override
  State<MyCard> createState() => _MyCard();
}

class _MyCard extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 132,
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      margin: const EdgeInsets.fromLTRB(18, 6, 18, 6),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 242, 249, 248),
        borderRadius: BorderRadius.all(Radius.circular(18)),
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: Offset(0, 1),
            color: Colors.grey,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              widget.holeMessage.message,
              style: const TextStyle(fontSize: 21),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: FloatingActionButton(
                  onPressed: () => _like(context, widget.holeMessage),
                  mini: true,
                  tooltip: "❤ ${widget.holeMessage.like}",
                  child: const Icon(
                    CupertinoIcons.heart,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: FloatingActionButton(
                  onPressed: () => _block(context, widget.holeMessage),
                  mini: true,
                  child: const Icon(
                    CupertinoIcons.eye_slash,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: FloatingActionButton(
                  onPressed: () => _report(context, widget.holeMessage),
                  mini: true,
                  tooltip: "ID：${widget.holeMessage.id}\nIP地址：${widget.holeMessage.ip}\n时间：${DateFormat("yyyy-MM-dd HH:ss").format(widget.holeMessage.date)}",
                  child: const Icon(
                    CupertinoIcons.exclamationmark_triangle,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _like(BuildContext context, HoleMessage holeMessage) {
    likeHoleMessage(holeMessage).then(
      (value) => {
        if (value.ok <= 0) {holeMessage.like--}
      },
    );
    setState(() {
      holeMessage.like++;
    });
  }

  void _report(BuildContext context, HoleMessage holeMessage) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('你确认要报告此消息吗'),
          content: Text('内容：${holeMessage.message}'),
          actions: [
            TextButton(
              child: const Text('取消'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('确认'),
              onPressed: () {
                Navigator.pop(context);
                showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: const Text('报告完毕'),
                      content: Text('消息ID：${holeMessage.id}'),
                      actions: [
                        TextButton(
                          child: const Text('确认'),
                          onPressed: () {
                            reportHoleMessage(holeMessage);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _block(BuildContext context, HoleMessage holeMessage) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('你确认要屏蔽此消息吗'),
          content: Text('内容：${holeMessage.message}'),
          actions: [
            TextButton(
              child: const Text('取消'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('确认'),
              onPressed: () {
                setState(() {
                  widget.holeMessage.message = "";
                  widget.onRemove();
                });
                Navigator.pop(context);
                showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: const Text('已屏蔽'),
                      content: Text('消息ID：${holeMessage.id}'),
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
              },
            ),
          ],
        );
      },
    );
  }
}
