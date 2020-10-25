import 'package:boardgame_companion/db/boardgames_db.dart';
import 'package:boardgame_companion/model/boardgame.dart';
import 'package:boardgame_companion/model/phases/phase-step.dart';
import 'package:boardgame_companion/model/phases/phase.dart';

class DataService {
  Future saveBoardgames(List<Boardgame> boardgames) {
    throw Exception();
  }

  Future deleteBoardgames(List<String> ids) {
    throw Exception();
  }

  Future<List<Boardgame>> getBoardgames() async {
    var db = await BoardgamesDb.getDatabase();
    var results = await db.query("boardgames");
    return results.map((e) => Boardgame.fromMap(e)).toList(growable: false);
  }

  Future<Boardgame> getBoardgame(String id) {
    throw Exception();
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
