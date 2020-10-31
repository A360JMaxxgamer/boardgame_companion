import 'package:boardgame_companion/model/phases/phase.dart';
import 'package:boardgame_companion/pages/edit-phase-page.dart';
import 'package:boardgame_companion/services/bloc-provider.dart';
import 'package:boardgame_companion/widgets/bg-card.dart';
import 'package:boardgame_companion/widgets/item_action_bar.dart';
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
          var phases = snapshot.data?.toList();
          return ListView(
              shrinkWrap: true,
              children: List<Widget>.generate(phases.length, (index) {
                var phase = phases[index];
                return BgCard(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(phase.title),
                    ItemActionBar(
                      onEdit: () => Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return EditPhasePage(
                            phaseId: phase.id,
                          );
                        },
                      )),
                      onDelete: () => bloc.deletePhases([phase.id]),
                    )
                  ],
                ));
              }));
        });
  }
}
