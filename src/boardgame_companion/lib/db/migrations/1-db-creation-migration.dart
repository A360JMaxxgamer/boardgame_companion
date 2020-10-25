import 'package:sqflite_common/sqlite_api.dart';
import 'migration.dart';

class DbCreationMigration implements Migration {
  @override
  int id = 1;

  @override
  Future<void> run(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
    await db.execute('''CREATE TABLE boardgames(
          id TEXT PRIMARY KEY, 
          name TEXT, 
          description TEXT);''');
    await db.execute('''CREATE TABLE phases(
          id TEXT PRIMARY KEY,
          boardgamesid TEXT,
          phaseindex INTEGER,
          title TEXT,
          FOREIGN KEY(boardgamesid) REFERENCES boardgames(id)
          );''');
    await db.execute('''CREATE TABLE phasesteps(
          id TEXT PRIMARY KEY,
          phaseid TEXT,
          title TEXT,
          details TEXT,
          FOREIGN KEY(phaseid) REFERENCES phases(id));''');
  }

  @override
  Map<String, dynamic> toMap() {
    return {"id": id};
  }
}
