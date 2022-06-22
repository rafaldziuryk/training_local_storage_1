import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sqflite/sqflite.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  PageTwoState createState() => PageTwoState();
}

class PageTwoState extends State<PageTwo> {
  int _counter = 0;

  Database? database;

  Future<void> _doubleIncrementCounter() async {
    var counter = _counter;
    await database?.transaction((txn) {
      final batch = txn.batch();
      batch.rawUpdate('UPDATE Counter SET value = ?', [++counter]);
      batch.rawUpdate('UPDATE Counter SET value = ?', [++counter]);
      return batch.commit();
    });
    setState(() {
      _counter = counter;
    });
  }

  Future<void> _incrementCounter() async {
    final counter = _counter + 1;
    await database?.rawUpdate('UPDATE Counter SET value = ?', [counter]);
    setState(() {
      _counter = counter;
    });
  }

  @override
  void initState() {
    super.initState();
    getDatabasesPath()
        .then((value) => openDatabase(value + 'demo.db', version: 1, onCreate: (Database db, int version) async {
              // When creating the db, create the table
              await db.execute('CREATE TABLE Counter (id INTEGER PRIMARY KEY, value INTEGER)');
            }))
        .then((value) {
      value.rawInsert('INSERT INTO Counter(value) VALUES (?)', [0]);
      return database = value;
    }).then((value) async {
      List<Map> list = await value.rawQuery('SELECT * FROM Counter');
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          _counter = list[0]['value'];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Two Demo'),
      ),
      body: Center(child: Text('Tapped $_counter times')),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            heroTag: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: _doubleIncrementCounter,
            tooltip: 'Increment 2',
            heroTag: 'Increment 2',
            child: const Text('++'),
          ),
        ],
      ),
    );
  }
}
