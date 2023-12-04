import 'package:hive/hive.dart';

part 'employee.g.dart'; // This file will be generated

@HiveType(typeId: 0)
class Employee {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String position;

  Employee({required this.id, required this.name, required this.position});
}
