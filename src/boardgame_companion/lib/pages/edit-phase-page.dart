import 'package:boardgame_companion/model/phases/phase-step.dart';
import 'package:boardgame_companion/model/phases/phase.dart';
import 'package:boardgame_companion/services/bloc-provider.dart';
import 'package:boardgame_companion/widgets/bg-card.dart';
import 'package:boardgame_companion/widgets/item_action_bar.dart';
import 'package:boardgame_companion/widgets/name_dialog.dart';
import 'package:boardgame_companion/widgets/phase-general.dart';
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
            body: ListView(
              children: List<Widget>.generate(phase.steps.length, (index) {
                var step = phase.steps[index];
                return BgCard(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(step.title),
                    ItemActionBar(
                      onEdit: () => {},
                      onDelete: () => {
                        bloc.deleteSteps([step.id])
                      },
                    )
                  ],
                ));
              }),
            ));
      },
    );
  }
}
