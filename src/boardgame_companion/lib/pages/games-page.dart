import 'package:boardgame_companion/model/boardgame.dart';
import 'package:boardgame_companion/pages/edit-game-page.dart';
import 'package:boardgame_companion/services/bloc-provider.dart';
import 'package:boardgame_companion/widgets/bg-card.dart';
import 'package:boardgame_companion/widgets/name_dialog.dart';
import 'package:flutter/material.dart';

class GamesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).boardgameBloc;
    return Scaffold(
        appBar: AppBar(
          title: Text("Games"),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add_circle),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => NameDialog(
                        title: "New game",
                        onSubmit: (name) {
                          var game = Boardgame();
                          game.name = name;
                          bloc.saveBoardgame(game);
                        },
                      ));
            }),
        body: StreamBuilder<List<Boardgame>>(
          stream: bloc.boardgames,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ErrorWidget(snapshot.error);
            }

            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            return ListView(
              children: List<Widget>.generate(snapshot.data.length, (index) {
                var game = snapshot.data[index];
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
                            onPressed: () {
                              // _dataService.deleteBoardgames([game.id]);
                            },
                          )
                        ],
                      )
                    ],
                  ),
                );
              }),
            );
          },
        ));
  }
}
