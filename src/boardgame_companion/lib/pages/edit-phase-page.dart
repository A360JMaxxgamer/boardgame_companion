import 'package:boardgame_companion/model/phases/phase.dart';
import 'package:boardgame_companion/widgets/phase-general.dart';
import 'package:boardgame_companion/widgets/steps-view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditPhasePage extends StatefulWidget {
  final String phaseId;

  const EditPhasePage({Key key, this.phaseId}) : super(key: key);

  _EditPhasePageState createState() => _EditPhasePageState(phaseId);
}

class _EditPhasePageState extends State<EditPhasePage> {
  final String phaseId;

  Phase phase;

  _EditPhasePageState(this.phaseId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit phase"),
        ),
        body: Flex(
          direction: Axis.vertical,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Expanded(
                child: Column(
                  children: [
                    PhaseGeneral(phase: phase),
                    StepsView(phase: phase),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
