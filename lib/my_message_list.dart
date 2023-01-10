import 'package:flutter/widgets.dart';
import 'package:tree_hole/hole_size.dart';
import 'package:tree_hole/my_card.dart';
import 'package:tree_hole/my_message.dart';

class MyMessageList extends StatelessWidget {
  const MyMessageList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cache = {};
    return FutureBuilder<HoleSize>(
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

            var card = MyCard(futureMessage: cache[index]);
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
    );
  }
}
