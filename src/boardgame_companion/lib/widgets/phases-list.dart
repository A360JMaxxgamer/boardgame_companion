import 'package:boardgame_companion/model/phases/phase.dart';
import 'package:boardgame_companion/services/bloc-provider.dart';
import 'package:flutter/material.dart';

class PhasesList extends StatelessWidget {
  const PhasesList({
    Key key,
    @required this.boardgameId,
  }) : super(key: key);
  final String boardgameId;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).boardgameBloc;

    return StreamBuilder<Iterable<Phase>>(
        stream: bloc.boardgames.map((game) => game
            .map((e) => e.phases)
            .expand((phase) => phase)
            .where((phase) => phase.boardGameId == boardgameId)),
        initialData: [],
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          var phases = snapshot.data;
          return Column(children: [
            Column(
                children: List<Widget>.generate(phases.length, (index) {
              return Card(
                  child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [Text(phases.toList()[index].title)],
                ),
              ));
            })),
            IconButton(
                alignment: Alignment.centerRight,
                icon: Icon(Icons.add_circle),
                onPressed: () {
                  var phase = Phase();
                  phase.boardGameId = boardgameId;
                  //_dataService.savePhases([phase]);
                })
          ]);
        });
  }
}
