import 'package:boardgame_companion/model/boardgame.dart';
import 'package:boardgame_companion/services/bloc-provider.dart';
import 'package:boardgame_companion/widgets/bg-card.dart';
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
            appBar: AppBar(
              title: Text(game.name),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.save),
              onPressed: () {
                if (_formKey.currentState.validate() ?? false) {
                  bloc.saveBoardgame(game);
                }
              },
            ),
            body: Form(
                key: _formKey,
                child: Column(
                  children: [
                    BgCard(
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.text,
                            onChanged: (text) => game.name = text,
                            decoration: InputDecoration(
                                labelText: "Name",
                                hintText: "The name of the game."),
                            initialValue: game.name,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter a name";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            minLines: 1,
                            maxLines: 8,
                            keyboardType: TextInputType.multiline,
                            onChanged: (text) => game.descpription = text,
                            decoration: InputDecoration(
                                labelText: "Description",
                                hintText: "A short description of the game."),
                            initialValue: game.descpription,
                          ),
                        ],
                      ),
                    ),
                    BgCard(
                      child: PhasesList(boardgameId: widget.boardgameId),
                    )
                  ],
                )));
      },
    );
  }
}
