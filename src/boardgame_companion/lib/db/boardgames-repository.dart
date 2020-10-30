import 'dart:convert';
import 'package:boardgame_companion/model/boardgame.dart';
import 'package:boardgame_companion/model/phases/phase.dart';
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
    var results = (await _store.record(_boardgamesRecord).get(_database));

    if (results == null) {
      await _store
          .record(_boardgamesRecord)
          .add(_database, toJson(List<Boardgame>.empty()));
      results = await _store.record(_boardgamesRecord).get(_database);
    }
    var boardgames = fromJson(results);
    _boardgamesSubject.add(boardgames);
  }

  void saveBoardgame(Boardgame boardgame) {
    var snap = this.snapshot;
    var existing = snap.firstWhere((element) => element.id == boardgame.id,
        orElse: () => null);

    if (existing == null) {
      snap.add(boardgame);
    }
    _store.record(_boardgamesRecord).update(_database, toJson(snap));
    _boardgamesSubject.add(snap);
  }

  void savePhases(List<Phase> phases) {
    phases.forEach((phase) {
      var game = this.snapshot.firstWhere(
          (game) => game.id == phase.boardGameId,
          orElse: () => null);
      if (game == null) {
        throw ArgumentError("Try to add phase with unknown game");
      }

      var existingPhase = game.phases
          .firstWhere((element) => element.id == phase.id, orElse: () => null);
      if (existingPhase == null) {
        game.phases.add(phase);
      }

      saveBoardgame(game);
    });
  }

  Map<String, dynamic> toJson(List<Boardgame> boardgames) {
    return {"boardgames": jsonEncode(boardgames)};
  }

  List<Boardgame> fromJson(Map map) {
    var result = List<Boardgame>();
    var list = jsonDecode(map["boardgames"]) as List;
    var games = list.map((e) => Boardgame.fromJson(e));
    result.addAll(games);
    return result;
  }
}
