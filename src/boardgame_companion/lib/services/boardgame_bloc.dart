import 'package:boardgame_companion/db/boardgames_repository.dart';
import 'package:boardgame_companion/model/boardgame.dart';
import 'package:boardgame_companion/model/phases/phase_step.dart';
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

  void saveStepList(String boardgameId, String phaseId, List<PhaseStep> steps) {
    _repository.saveStepList(boardgameId, phaseId, steps);
  }

  void savePhaseList(String boardgameId, List<Phase> phases) {
    _repository.savePhaseList(boardgameId, phases);
  }

  Stream<List<Boardgame>> get boardgames => _repository.boardgames;
}
