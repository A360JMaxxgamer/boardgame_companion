import 'package:boardgame_companion/model/phases/phase.dart';
import 'package:boardgame_companion/services/bloc-provider.dart';
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
              title: Text("Edit phase"),
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
                child: Icon(Icons.add_circle), onPressed: () => {}),
            body: Flex(
              direction: Axis.vertical,
              children: List<Widget>.generate(phase.steps.length, (index) {
                var step = phase.steps[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(step.title),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => {},
                    )
                  ],
                );
              }),
            ));
      },
    );
  }
}
