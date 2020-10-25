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

  Map<String, dynamic> toMap() {
    return {"id": id, "phaseId": phaseId, "title": title, "details": details};
  }
}
