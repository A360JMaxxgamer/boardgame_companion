import 'package:boardgame_companion/model/boardgame.dart';
import 'package:boardgame_companion/pages/edit_game_page.dart';
import 'package:boardgame_companion/pages/phase_page.dart';
import 'package:boardgame_companion/services/boardgame_bloc.dart';
import 'package:boardgame_companion/widgets/bg_card.dart';
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
      Row(
        children: [
          IconButton(
              icon: Icon(Icons.play_arrow),
              onPressed: () => {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return PhasePage(boardgameId: game.id);
                    }))
                  }),
          Text(game?.name),
        ],
      ),
      ItemActionBar(
          onEdit: () => Navigator.of(context).push(MaterialPageRoute(
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
