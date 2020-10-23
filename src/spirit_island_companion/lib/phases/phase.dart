import 'package:spirit_island_companion/phases/phase-step.dart';

class Phase {
  final int index;
  final String title;
  final List<PhaseStep> steps;

  Phase({this.index, this.title, this.steps});
}
