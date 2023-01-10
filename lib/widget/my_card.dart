import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tree_hole/pojo/hole_message.dart';

class MyCard extends StatelessWidget {
  const MyCard({
    super.key,
    required this.futureMessage,
  });

  final Future<HoleMessage> futureMessage;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HoleMessage>(
      future: futureMessage,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var holeMessage= snapshot.data!;

          return Container(
            // height: 132,
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
              "${holeMessage.message}\n赞：${holeMessage.like}\nIP地址：${holeMessage.ip}\n时间：${DateFormat("yyyy-MM-dd HH:ss").format(holeMessage.date)}",
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 32),
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
