import 'package:boardgame_companion/model/boardgame.dart';
import 'package:boardgame_companion/pages/edit-game-page.dart';
import 'package:boardgame_companion/services/boardgame-bloc.dart';
import 'package:boardgame_companion/widgets/bg-card.dart';
import 'package:boardgame_companion/widgets/item_action_bar.dart';
import 'package:flutter/material.dart';

class GameCard extends StatelessWidget {
  const GameCard({
    Key key,
    @required this.game,
    @required this.bloc,
  }) : super(key: key);

  final Boardgame game;
  final BoardgameBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BgCard(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(game?.name),
      ItemActionBar(
          onEdit: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return EditGamePage(
                    boardgameId: game.id,
                  );
                },
              )),
          onDelete: () => bloc.deleteBoardgame(game.id))
    ]));
  }
}
