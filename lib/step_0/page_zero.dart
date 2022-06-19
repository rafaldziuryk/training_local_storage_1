import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageZero extends StatefulWidget {
  const PageZero({Key? key}) : super(key: key);

  @override
  PageZeroState createState() => PageZeroState();
}

class PageZeroState extends State<PageZero> {
  int _counter = 0;

  Future<void> _incrementCounter() async {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Zero Demo'),
      ),
      body: Center(child: Text('Tapped $_counter times')),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
