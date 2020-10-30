import 'package:boardgame_companion/model/boardgame.dart';
import 'package:boardgame_companion/model/phases/phase.dart';
import 'package:boardgame_companion/services/bloc-provider.dart';
import 'package:boardgame_companion/widgets/edit_board_game_details.dart';
import 'package:boardgame_companion/widgets/name_dialog.dart';
import 'package:boardgame_companion/widgets/phases-list.dart';
import 'package:flutter/material.dart';

class EditGamePage extends StatefulWidget {
  final String boardgameId;

  EditGamePage({Key key, @required this.boardgameId}) : super(key: key);

  @override
  _EditGamePageState createState() => _EditGamePageState();
}

class _EditGamePageState extends State<EditGamePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).boardgameBloc;
    return StreamBuilder<Boardgame>(
      stream: bloc.boardgames
          .expand((element) => element)
          .where((element) => element.id == widget.boardgameId),
      initialData: null,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        var game = snapshot.data;
        return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              actions: [
                IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        child: EditBoardGameDetails(
                            formKey: _formKey, game: game, bloc: bloc),
                      );
                    })
              ],
              title: Text(game.name),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                      heroTag: "newPhase",
                      child: Icon(Icons.add),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => NameDialog(
                                  title: "New phase",
                                  onSubmit: (name) {
                                    var phase = Phase();
                                    phase.title = name;
                                    phase.boardGameId = game.id;
                                    bloc.savePhases([phase]);
                                  },
                                ));
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    heroTag: "saveGame",
                    child: Icon(Icons.save),
                    onPressed: () {
                      if (_formKey.currentState.validate() ?? false) {
                        bloc.saveBoardgame(game);
                      }
                    },
                  ),
                ),
              ],
            ),
            body: PhasesList(boardgameId: widget.boardgameId));
      },
    );
  }
}
