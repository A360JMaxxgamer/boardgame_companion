import 'package:boardgame_companion/model/boardgame.dart';
import 'package:boardgame_companion/model/phases/phase.dart';
import 'package:boardgame_companion/services/bloc-provider.dart';
import 'package:boardgame_companion/services/boardgame-bloc.dart';
import 'package:boardgame_companion/widgets/phases-list.dart';
import 'package:flutter/material.dart';

class EditGamePage extends StatelessWidget {
  final String boardgameId;

  const EditGamePage({Key key, @required this.boardgameId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).boardgameBloc;
    return Scaffold(
        appBar: AppBar(),
        body: StreamBuilder<Boardgame>(
          stream: bloc.boardgames
              .expand((element) => element)
              .where((element) => element.id == boardgameId),
          initialData: null,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            var game = snapshot.data;
            return Column(
              children: [
                Text(game.name),
                PhasesList(boardgameId: boardgameId),
              ],
            );
          },
        ));
  }
}
