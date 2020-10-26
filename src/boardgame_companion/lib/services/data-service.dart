import 'package:boardgame_companion/db/boardgames_db.dart';
import 'package:boardgame_companion/model/boardgame.dart';
import 'package:boardgame_companion/model/phases/phase-step.dart';
import 'package:boardgame_companion/model/phases/phase.dart';
import 'package:rxdart/rxdart.dart';

class DataService {
  static BehaviorSubject<List<Boardgame>> _dataChanged;

  BehaviorSubject<List<Boardgame>> get dataObservable => _dataChanged;

  DataService() {
    if (_dataChanged == null) {
      _dataChanged =
          new BehaviorSubject<List<Boardgame>>.seeded(List<Boardgame>.empty());
    }
  }

  Future saveBoardgames(List<Boardgame> boardgames) async {
    var db = await BoardgamesDb.getDatabase();
    for (var i = 0; i < boardgames.length; i++) {
      var boardgame = boardgames[i];
      var existing = await getBoardgame(boardgame.id);

      if (existing != null) {
        db.update("boardgames", boardgame.toMap());
      } else {
        db.insert("boardgames", boardgame.toMap());
      }
    }
    await fetchBoardgames();
  }

  Future deleteBoardgames(List<String> ids) {
    throw Exception();
  }

  Future fetchBoardgames() async {
    var db = await BoardgamesDb.getDatabase();
    var results = await db.query("boardgames");
    var boardgames =
        results.map((e) => Boardgame.fromMap(e)).toList(growable: false);
    _dataChanged.add(boardgames);
  }

  Future<Boardgame> getBoardgame(String id) async {
    var db = await BoardgamesDb.getDatabase();
    var values = await db.query("boardgames", where: "id = ?", whereArgs: [id]);

    return values.isEmpty ? null : Boardgame.fromMap(values.first);
  }

  Future savePhases(List<Phase> phases) {
    throw Exception();
  }

  Future deletePhases(List<String> ids) {
    throw Exception();
  }

  Future<List<Phase>> getPhases() {
    throw Exception();
  }

  Future<Phase> getPhase(String id) {
    throw Exception();
  }

  Future savePhaseSteps(List<Phase> phaseSteps) {
    throw Exception();
  }

  Future deletePhaseSteps(List<String> ids) {
    throw Exception();
  }

  Future<List<PhaseStep>> getPhaseSteps() {
    throw Exception();
  }

  Future<PhaseStep> getPhaseStep(String id) {
    throw Exception();
  }
}
