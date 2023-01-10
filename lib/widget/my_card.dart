import 'package:flutter/material.dart';
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
          return Container(
            height: 132,
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
              "${snapshot.data!.message}\n赞：${snapshot.data!.like}\nIP地址：${snapshot.data!.ip}",
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
