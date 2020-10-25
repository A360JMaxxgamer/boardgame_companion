import 'package:sqflite/sqflite.dart';

abstract class Migration {
  int id;
  Future<void> run(Database db);

  Map<String, dynamic> toMap();
}
