import 'dart:convert';

import 'package:boardgame_companion/model/phases/phase-step.dart';
import 'package:uuid/uuid.dart';

class Phase {
  String id;
  String boardGameId;
  int index = 0;
  String title = "";
  List<PhaseStep> steps = List<PhaseStep>.empty(growable: true);

  Phase() {
    var uuid = new Uuid();
    id = uuid.v4();
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "boardgamesid": boardGameId,
      "index": index,
      "title": title,
      "steps": jsonEncode(steps)
    };
  }

  Phase.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        boardGameId = json["boardgamesid"],
        index = json["index"],
        title = json["title"],
        steps = (jsonDecode(json["steps"]) as List<dynamic>)
            .map((step) => PhaseStep.fromJson(step))
            .toList();
}
