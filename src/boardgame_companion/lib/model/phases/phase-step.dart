import 'package:uuid/uuid.dart';

class PhaseStep {
  String id;
  String phaseId;
  String title = "";
  String details = "";
  bool checked = false;

  PhaseStep() {
    var uuid = new Uuid();
    id = uuid.v4();
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "phaseid": phaseId, "title": title, "details": details};
  }

  PhaseStep.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        phaseId = json["phaseid"],
        title = json["title"],
        details = json["details"];
}
