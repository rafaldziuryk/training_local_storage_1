import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'counter.dart';
import 'counter_adapter.dart';

class PageFour extends StatefulWidget {
  const PageFour({Key? key}) : super(key: key);

  @override
  PageFourState createState() => PageFourState();
}

class PageFourState extends State<PageFour> {
  CounterHive _counter = CounterHive(value: 0);

  late final Box box;

  Future<void> _incrementCounter() async {
    final counter = CounterHive(value: _counter.value + 1);
    box.put('counter4', counter);
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
          _counter = box.get('counter4', defaultValue: CounterHive(value: 0));
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
      body: Center(child: Text('Tapped ${_counter.value} times')),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
