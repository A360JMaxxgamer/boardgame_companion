import 'dart:convert';
import 'package:boardgame_companion/model/boardgame.dart';
import 'package:boardgame_companion/model/phases/phase-step.dart';
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
          .add(_database, _toJson(List<Boardgame>.empty()));
      results = await _store.record(_boardgamesRecord).get(_database);
    }
    var boardgames = _fromJson(results);
    _boardgamesSubject.add(boardgames);
  }

  void saveBoardgame(Boardgame boardgame) {
    var snap = this.snapshot;
    var existing = snap.firstWhere((element) => element.id == boardgame.id,
        orElse: () => null);

    if (existing == null) {
      snap.add(boardgame);
    }
    _saveToDatabase(snap);
    _boardgamesSubject.add(snap);
  }

  void deleteBoardgame(String boardgameId) {
    var games = this.snapshot;
    var boardgame = games.firstWhere((game) => game.id == boardgameId);

    if (boardgame != null) {
      games.remove(boardgame);
      _saveToDatabase(games);
      _boardgamesSubject.add(games);
    }
  }

  void savePhases(List<Phase> phases) {
    phases.forEach((phase) {
      var game = this.snapshot.firstWhere(
          (game) => game.id == phase.boardGameId,
          orElse: () => null);
      if (game == null) {
        throw ArgumentError("Try to add phase with unknown boardgame");
      }

      var existingPhase = game.phases
          .firstWhere((element) => element.id == phase.id, orElse: () => null);
      if (existingPhase == null) {
        game.phases.add(phase);
      }

      saveBoardgame(game);
    });
  }

  void deletePhases(List<String> ids) {
    ids.forEach((phaseId) {
      var phase = this
          .snapshot
          .expand((game) => game.phases)
          .firstWhere((phase) => phase.id == phaseId, orElse: () => null);
      if (phase == null) {
        throw ArgumentError("Try to remove phase with unknown id");
      }
      var game =
          this.snapshot.firstWhere((game) => game.id == phase.boardGameId);
      if (game == null) {
        throw ArgumentError("Try to remove phase with unknown boardgame");
      }

      game.phases.remove(phase);

      saveBoardgame(game);
    });
  }

  void _saveToDatabase(List<Boardgame> snap) {
    _store.record(_boardgamesRecord).update(_database, _toJson(snap));
  }

  void saveSteps(List<PhaseStep> steps) {
    steps.forEach((step) {
      var games = this.snapshot;
      games.forEach((game) {
        var phase = game.phases.firstWhere(
            (element) => element.id == step.phaseId,
            orElse: () => null);
        if (phase == null) {
          return;
        }

        var existing = phase.steps
            .firstWhere((element) => element.id == step.id, orElse: () => null);

        if (existing == null) {
          phase.steps.add(step);
        }
        saveBoardgame(game);
      });
    });
  }

  Map<String, dynamic> _toJson(List<Boardgame> boardgames) {
    return {"boardgames": jsonEncode(boardgames)};
  }

  List<Boardgame> _fromJson(Map map) {
    var result = List<Boardgame>();
    var list = jsonDecode(map["boardgames"]) as List;
    var games = list.map((e) => Boardgame.fromJson(e));
    result.addAll(games);
    return result;
  }
}
