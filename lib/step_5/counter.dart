import 'package:hive_flutter/hive_flutter.dart';

part 'counter.g.dart';

@HiveType(typeId: 1)
class Counter {
  @HiveField(0)
  final int value;

  const Counter({
    required this.value,
  });
}
