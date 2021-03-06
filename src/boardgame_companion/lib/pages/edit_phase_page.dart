import 'package:boardgame_companion/model/phases/phase_step.dart';
import 'package:boardgame_companion/model/phases/phase.dart';
import 'package:boardgame_companion/services/bloc_provider.dart';
import 'package:boardgame_companion/widgets/bg_card.dart';
import 'package:boardgame_companion/widgets/item_action_bar.dart';
import 'package:boardgame_companion/widgets/name_dialog.dart';
import 'package:boardgame_companion/widgets/phase_general.dart';
import 'package:boardgame_companion/widgets/step_details.dart';
import 'package:flutter/material.dart';

class EditPhasePage extends StatelessWidget {
  final String phaseId;

  const EditPhasePage({Key key, this.phaseId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).boardgameBloc;
    return StreamBuilder<Phase>(
        stream: bloc.boardgames
            .expand((game) => game)
            .expand((game) => game.phases)
            .where((phase) => phase.id == phaseId),
        initialData: null,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          var phase = snapshot.data;
          return Scaffold(
              appBar: AppBar(
                title: Text("${phase.title} - Steps"),
                actions: [
                  IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          child: AlertDialog(
                            content: PhaseGeneral(phase: phase),
                          ));
                    },
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.add_circle),
                  onPressed: () {
                    var step = PhaseStep();
                    step.phaseId = phase.id;
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => NameDialog(
                              title: "New step",
                              onSubmit: (name) {
                                var step = PhaseStep();
                                step.title = name;
                                step.phaseId = phase.id;
                                bloc.saveSteps([step]);
                              },
                            ));
                  }),
              body: ReorderableListView(
                  onReorder: (oldindex, newindex) {
                    var item = phase.steps[oldindex];
                    phase.steps.insert(newindex, item);
                    phase.steps.removeAt(oldindex);
                    bloc.saveStepList(phase.boardGameId, phase.id, phase.steps);
                  },
                  children: [
                    for (final step in phase.steps)
                      BgCard(
                        key: ValueKey(step),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(step.title),
                              ItemActionBar(
                                onEdit: () async {
                                  showDialog(
                                      context: context,
                                      child: AlertDialog(
                                        content: StepDetails(
                                          step: step,
                                        ),
                                      ));
                                },
                                onDelete: () => {
                                  bloc.deleteSteps([step.id])
                                },
                              )
                            ]),
                      )
                  ]));
        });
  }
}
