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

import 'package:flutter/material.dart';
import 'package:tree_hole/pojo/hole_size.dart';
import 'package:tree_hole/widget/my_card.dart';
import 'package:tree_hole/pojo/hole_message.dart';

class MyMessageList extends StatefulWidget {
  const MyMessageList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyMessageList();
  }
}

class _MyMessageList extends State<MyMessageList> {
  Map<int, HoleMessage> cache = {};
  Set<String> hide = {};
  var block = 0;

  Future<HoleSize> _holeSizeFuture = getHoleSize();

  Future<void> _refresh() async {
    setState(() {
      cache.clear();
      hide.clear();
      block = 0;
      _holeSizeFuture = getHoleSize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HoleSize>(
      future: _holeSizeFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('加载失败'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('没有数据'));
        }

        final size = snapshot.data!.size;

        return RefreshIndicator(
          onRefresh: _refresh,
          child: ListView.builder(
            itemCount: size + 1,
            itemBuilder: ((context, index) {
              return FutureBuilder<HoleMessage>(
                future: myGetMESSAGE(index),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                      height: 132,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (snapshot.hasError) {
                    return const SizedBox(
                      height: 132,
                      child: Center(child: Text('加载失败')),
                    );
                  } else if (!snapshot.hasData) {
                    return const SizedBox(
                      height: 132,
                      child: Center(child: Text('没有数据')),
                    );
                  }

                  final holeMessage = snapshot.data!;
                  if (!cache.containsKey(index)) {
                    cache[index] = holeMessage;
                  }
                  if (index < size) {
                    if (cache[index]!.message != "") {
                      return MyCard(
                        holeMessage: cache[index]!,
                        onRemove: () {
                          setState(() {
                            block++;
                          });
                        },
                      );
                    } else {
                      hide.add(cache[index]!.id);
                      return Container();
                    }
                  } else if (index == size) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Center(
                        child: Text(
                          "加载完毕",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              );
            }),
          ),
        );
      },
    );
  }

  Future<HoleMessage> myGetMESSAGE(int index) async {
    if (cache.containsKey(index)) {
      return cache[index]!;
    }
    return getMESSAGE(index);
  }
}
