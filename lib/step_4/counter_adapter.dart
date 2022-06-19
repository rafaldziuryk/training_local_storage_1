import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_storage_1/step_4/counter.dart';

class CounterAdapter extends TypeAdapter<Counter> {
  @override
  int get typeId => 0;

  @override
  Counter read(BinaryReader reader) {
    return Counter(value: reader.readInt());
  }

  @override
  void write(BinaryWriter writer, Counter obj) {
    writer.writeInt(obj.value);
  }
}
