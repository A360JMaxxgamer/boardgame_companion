import 'package:boardgame_companion/model/boardgame.dart';
import 'package:boardgame_companion/pages/edit-game-page.dart';
import 'package:boardgame_companion/services/boardgame-bloc.dart';
import 'package:boardgame_companion/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';

import 'bg-card.dart';

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(game?.name),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return EditGamePage(
                        boardgameId: game.id,
                      );
                    },
                  ))
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  showDialog(
                      context: context,
                      child: ConfirmationDialog(
                          message:
                              "Do you really want to delete this game?",
                          onConfirmed: () =>
                              bloc.deleteBoardgame(game.id)));
                },
              )
            ],
          )
        ],
      ),
    );
  }
}