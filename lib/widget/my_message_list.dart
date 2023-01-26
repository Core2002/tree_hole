import 'package:flutter/material.dart';
import 'package:tree_hole/pojo/hole_size.dart';
import 'package:tree_hole/widget/my_card.dart';
import 'package:tree_hole/pojo/hole_message.dart';

class MyMessageList extends StatefulWidget {
  const MyMessageList({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyMessageList();
  }
}

class _MyMessageList extends State {
  Map<int, HoleMessage> cache = {};
  var block = 0;

  @override
  Widget build(BuildContext context) {
    var size = 0;
    return FutureBuilder<HoleSize>(
      future: getHoleSize(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          size = snapshot.data!.size;
        }

        var listView = ListView.builder(
          itemCount: size + 1,
          itemBuilder: ((context, index) {
            return FutureBuilder<HoleMessage>(
              future: getMESSAGE(index),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (!cache.containsKey(index)) {
                    cache[index] = snapshot.data!;
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
                      return Container();
                    }
                  } else {
                    return Container();
                  }
                } else {
                  if (index == size) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Center(
                        child: Text(
                          "加载完毕，共 ${size - block} 个",
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                }
              },
            );
          }),
        );

        return RefreshIndicator(
          onRefresh: refresh,
          child: listView,
        );
      },
    );
  }

  Future refresh() async {
    setState(() {
      cache = {};
      block = 0;
    });
  }
}
