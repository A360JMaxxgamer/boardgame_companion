import 'package:boardgame_companion/model/phases/phase-step.dart';
import 'package:uuid/uuid.dart';

class Phase {
  String id;
  String boardGameId;
  int index = 0;
  String title = "";
  List<PhaseStep> steps = List<PhaseStep>.empty();

  Phase() {
    var uuid = new Uuid();
    id = uuid.v4();
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "boardGameId": boardGameId,
      "phaseindex": index,
      "title": title
    };
  }
}
