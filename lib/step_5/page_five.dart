import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_storage_1/step_5/counter.dart';

class PageFive extends StatefulWidget {
  const PageFive({Key? key}) : super(key: key);

  @override
  PageFiveState createState() => PageFiveState();
}

class PageFiveState extends State<PageFive> {
  int _counter = 0;

  late final Box box;

  Future<void> _incrementCounter() async {
    final counter = _counter + 1;
    box.put('counter3', counter);
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
      box = await Hive.openBox('Counter3');
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          _counter = box.get('counter3', defaultValue: 0);
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
