import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sqflite/sqflite.dart';

import 'counter_adapter.dart';

class PageFour extends StatefulWidget {
  const PageFour({Key? key}) : super(key: key);

  @override
  PageFourState createState() => PageFourState();
}

class PageFourState extends State<PageFour> {
  int _counter = 0;

  late final Box box;

  Future<void> _incrementCounter() async {
    final counter = _counter + 1;
    box.put('counter2', counter);
    setState(() {
      _counter = counter;
    });
  }

  @override
  void initState() {
    super.initState();
    Hive.initFlutter().then((value) async {
      if (!Hive.isAdapterRegistered(CounterAdapter().typeId)) {
        Hive.registerAdapter(CounterAdapter());
      }
      box = await Hive.openBox('Counter2');
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          _counter = box.get('counter2', defaultValue: 0);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Four Demo'),
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
