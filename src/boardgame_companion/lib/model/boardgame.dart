import 'package:boardgame_companion/model/phases/phase.dart';
import 'package:uuid/uuid.dart';

class Boardgame {
  String id;
  String name = "";
  String descpription = "";
  List<Phase> phases = List<Phase>.empty();

  Boardgame() {
    var uuid = new Uuid();
    id = uuid.v4();
  }

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "description": descpription};
  }

  static Boardgame fromMap(Map<String, dynamic> map) {
    var game = Boardgame();
    game.id = map["id"];
    game.name = map["name"];
    game.descpription = map["description"];
    return game;
  }
}
