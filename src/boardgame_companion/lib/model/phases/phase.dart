import 'package:boardgame_companion/model/phases/phase-step.dart';

class Phase {
  int index = 0;
  String title = "";
  List<PhaseStep> steps = List<PhaseStep>.empty();

  Phase();
}
