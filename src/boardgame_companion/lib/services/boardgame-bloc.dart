import 'package:boardgame_companion/db/boardgames-repository.dart';
import 'package:boardgame_companion/model/boardgame.dart';
import 'package:boardgame_companion/model/phases/phase-step.dart';
import 'package:boardgame_companion/model/phases/phase.dart';

class BoardgameBloc {
  BoardgamesRepository _repository;

  BoardgameBloc() : _repository = BoardgamesRepository();

  void saveBoardgame(Boardgame boardgame) {
    _repository.saveBoardgame(boardgame);
  }

  void deleteBoardgame(String id) {
    _repository.deleteBoardgame(id);
  }

  void fetchBoardgames() {
    _repository.fetchBoardgames();
  }

  void getBoardgame(String id) {}

  void savePhases(List<Phase> phases) {
    _repository.savePhases(phases);
  }

  void deletePhases(List<String> ids) {
    _repository.deletePhases(ids);
  }

  void getPhases() {}

  void getPhase(String id) {}

  void saveSteps(List<PhaseStep> phaseSteps) {
    _repository.saveSteps(phaseSteps);
  }

  void deletePhaseSteps(List<String> ids) {}

  void getPhaseSteps() {}

  void getPhaseStep(String id) {}

  Stream<List<Boardgame>> get boardgames => _repository.boardgames;
}
