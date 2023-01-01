import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tree Hole',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '树洞'),
    );
  }
}

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
      body: ListView.builder(
        itemBuilder: ((context, index) => Container(
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
                '$index awww $_counter',
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
