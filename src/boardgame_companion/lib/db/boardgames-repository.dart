import 'dart:convert';
import 'package:boardgame_companion/model/boardgame.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class BoardgamesRepository {
  Database _database;

  static const String _boardgamesRecord = "boardgames";

  final BehaviorSubject<List<Boardgame>> _boardgamesSubject;

  StoreRef _store;

  BoardgamesRepository()
      : _boardgamesSubject =
            BehaviorSubject<List<Boardgame>>.seeded(List.empty()) {
    _initDatabase();
  }

  Stream<List<Boardgame>> get boardgames => _boardgamesSubject.stream;

  List<Boardgame> get snapshot => _boardgamesSubject.value.toList() ?? [];

  void _initDatabase() async {
    var dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    var dbPath = join(dir.path, 'boardgames_companion.db');
    _database = await databaseFactoryIo.openDatabase(dbPath);
    _store = StoreRef.main();

    _store.record(_boardgamesRecord);

    fetchBoardgames();
  }

  void fetchBoardgames() async {
    var results =
        (await _store.record(_boardgamesRecord).get(_database)) as Map;
    var boardgames =
        results != null ? fromJson(results) : List<Boardgame>.empty();
    _boardgamesSubject.add(boardgames);
  }

  void saveBoardgame(Boardgame boardgame) {
    var snap = this.snapshot;
    var existing = snap.firstWhere((element) => element.id == boardgame.id,
        orElse: () => null);

    if (existing != null) {
      var index = snap.indexOf(existing);
      snap.replaceRange(index, index++, [boardgame]);
    } else {
      snap.add(boardgame);
    }
    _store.update(_database, toJson(snap));
    _boardgamesSubject.add(snap);
  }

  Map<String, dynamic> toJson(List<Boardgame> boardgames) {
    return {"boardgames": jsonEncode(boardgames)};
  }

  List<Boardgame> fromJson(Map<dynamic, dynamic> json) {
    return (json["boardgames"] as List<dynamic>)
        .map((e) => Boardgame.fromJson(e));
  }
}
