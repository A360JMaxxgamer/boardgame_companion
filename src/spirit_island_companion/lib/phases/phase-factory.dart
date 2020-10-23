import 'package:spirit_island_companion/phases/phase-step.dart';
import 'package:spirit_island_companion/phases/phase.dart';

class PhaseFactory {
  static List<Phase> createPhases() {
    return [
      Phase(index: 0, title: "Draw Card", steps: [
        PhaseStep(title: "Do something", details: "sndjaksdnajsdnaskdjans"),
        PhaseStep(
            title: "Do even one more thins",
            details:
                "dasdfgbiuoöklähgkm,flöhjmflgkhnmv lksd fnm slkd nv,  werhw kiefn  dsklf"),
      ]),
      Phase(index: 1, title: "Play Card", steps: [
        PhaseStep(title: "Do something", details: "sndjaksdnajsdnaskdjans"),
        PhaseStep(
            title: "Do even one more thins",
            details:
                "dasdfgbiuoöklähgkm,flöhjmflgkhnmv lksd fnm slkd nv,  werhw kiefn  dsklf"),
      ])
    ];
  }
}
