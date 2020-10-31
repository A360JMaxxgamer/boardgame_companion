import 'dart:convert';
import 'package:boardgame_companion/model/phases/phase.dart';
import 'package:uuid/uuid.dart';

class Boardgame {
  String id;
  String name = "";
  String descpription = "";
  List<Phase> phases = List<Phase>.empty(growable: true);

  Boardgame() {
    var uuid = new Uuid();
    id = uuid.v4();
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": descpription,
      "phases": jsonEncode(phases)
    };
  }

  Boardgame.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        descpription = json["description"],
        phases = (jsonDecode(json["phases"]) as List)
            .map((e) => Phase.fromJson(e))
            .toList();
}
