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

  void savePhases(List<Phase> phases) {
    _repository.savePhases(phases);
  }

  void deletePhases(List<String> ids) {
    _repository.deletePhases(ids);
  }

  void saveSteps(List<PhaseStep> phaseSteps) {
    _repository.saveSteps(phaseSteps);
  }

  void deleteSteps(List<String> ids) {
    _repository.deleteSteps(ids);
  }

  Stream<List<Boardgame>> get boardgames => _repository.boardgames;
}
