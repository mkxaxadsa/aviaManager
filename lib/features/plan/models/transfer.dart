import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 1)
class Transfer extends HiveObject {
  @HiveField(0)
  String date;

  @HiveField(1)
  String timeFrom;

  @HiveField(2)
  String timeTo;

  @HiveField(3)
  int passenger;

  @HiveField(4)
  int price;

  Transfer({
    required this.date,
    required this.timeFrom,
    required this.timeTo,
    required this.passenger,
    required this.price,
  });
}

class TransferAdapter extends TypeAdapter<Transfer> {
  @override
  final typeId = 1;

  @override
  Transfer read(BinaryReader reader) {
    return Transfer(
      date: reader.read(),
      timeFrom: reader.read(),
      timeTo: reader.read(),
      passenger: reader.read(),
      price: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Transfer obj) {
    writer.write(obj.date);
    writer.write(obj.timeFrom);
    writer.write(obj.timeTo);
    writer.write(obj.passenger);
    writer.write(obj.price);
  }
}
