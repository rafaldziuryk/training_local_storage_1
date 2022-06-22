import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_storage_1/step_4/counter.dart';

class CounterAdapter extends TypeAdapter<CounterHive> {
  @override
  int get typeId => 0;

  @override
  CounterHive read(BinaryReader reader) {
    return CounterHive(value: reader.readInt());
  }

  @override
  void write(BinaryWriter writer, CounterHive obj) {
    writer.writeInt(obj.value);
  }
}
