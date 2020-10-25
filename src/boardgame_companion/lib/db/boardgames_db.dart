import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'migrations/1-db-creation-migration.dart';
import 'migrations/migration.dart';

class BoardgamesDb {
  static Database _database;

  static const String migrationsTable = "migrations";

  static Future<Database> getDatabase() async {
    if (_database == null) {
      await initDatabase();
    }
    return _database;
  }

  static Future initDatabase() async {
    _database = await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'boardgames_companion.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          "CREATE TABLE migrations(id INTEGER PRIMARY KEY)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );

    // run migrations;
    await _runMigration(DbCreationMigration());
  }

  static Future<void> _runMigration(Migration migration) async {
    var migrations = await _database
        .query(migrationsTable, where: "id = ?", whereArgs: [migration.id]);
    if (migrations.isEmpty) {
      await _database.insert(migrationsTable, migration.toMap());
      await migration.run(_database);
    }
  }
}
