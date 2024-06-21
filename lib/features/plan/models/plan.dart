import 'package:hive_flutter/hive_flutter.dart';

import 'transfer.dart';

@HiveType(typeId: 0)
class Plan extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String departureTime;

  @HiveField(3)
  String arrivalTime;

  @HiveField(4)
  String fromCountry;

  @HiveField(5)
  String fromCity;

  @HiveField(6)
  String toCountry;

  @HiveField(7)
  String toCity;

  @HiveField(8)
  String date;

  @HiveField(9)
  int passenger;

  @HiveField(10)
  int price;

  @HiveField(11)
  Transfer transfer;

  Plan({
    required this.id,
    required this.name,
    required this.departureTime,
    required this.arrivalTime,
    required this.fromCountry,
    required this.fromCity,
    required this.toCountry,
    required this.toCity,
    required this.date,
    required this.passenger,
    required this.price,
    required this.transfer,
  });
}

class PlanAdapter extends TypeAdapter<Plan> {
  @override
  final typeId = 0;

  @override
  Plan read(BinaryReader reader) {
    return Plan(
      id: reader.read(),
      name: reader.read(),
      departureTime: reader.read(),
      arrivalTime: reader.read(),
      fromCountry: reader.read(),
      fromCity: reader.read(),
      toCountry: reader.read(),
      toCity: reader.read(),
      date: reader.read(),
      passenger: reader.read(),
      price: reader.read(),
      transfer: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Plan obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.departureTime);
    writer.write(obj.arrivalTime);
    writer.write(obj.fromCountry);
    writer.write(obj.fromCity);
    writer.write(obj.toCountry);
    writer.write(obj.toCity);
    writer.write(obj.date);
    writer.write(obj.passenger);
    writer.write(obj.price);
    writer.write(obj.transfer);
  }
}
