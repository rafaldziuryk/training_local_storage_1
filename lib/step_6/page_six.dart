import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'counter.dart';
import 'counter_adapter.dart';

class PageSix extends StatefulWidget {
  const PageSix({Key? key}) : super(key: key);

  @override
  PageSixState createState() => PageSixState();
}

class PageSixState extends State<PageSix> {
  List<CounterHive> counter = [];

  late final Box<CounterHive> box;
  late final StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    Hive.initFlutter().then((value) async {
      if (!Hive.isAdapterRegistered(CounterAdapter().typeId)) {
        Hive.registerAdapter(CounterAdapter());
      }
      box = await Hive.openBox('ListCounter');
      subscription = box.watch().listen((event) {
        setState(() {
          counter = box.values.toList();
        });
      });
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          counter = box.values.toList();
        });
      });
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Four Demo'),
      ),
      body: ListView.builder(
        itemCount: counter.length,
        itemBuilder: (context, index) {
          final item = counter[index];
          return ListTile(
            title: Text(item.value.toString()),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    final newItem = CounterHive(value: item.value - 1);
                    box.putAt(index, newItem);
                  },
                  icon: Icon(Icons.remove),
                ),
                IconButton(
                  onPressed: () {
                    final newItem = CounterHive(value: item.value + 1);
                    box.putAt(index, newItem);
                  },
                  icon: Icon(Icons.add),
                ),
                IconButton(
                  onPressed: () {
                    box.deleteAt(index);
                  },
                  icon: Icon(Icons.delete),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final newItem = CounterHive(value: 0);
          box.add(newItem);
        },
      ),
    );
  }
}
