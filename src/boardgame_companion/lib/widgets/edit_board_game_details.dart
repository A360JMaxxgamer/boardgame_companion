import 'package:boardgame_companion/model/boardgame.dart';
import 'package:boardgame_companion/services/boardgame-bloc.dart';
import 'package:flutter/material.dart';


class EditBoardGameDetails extends StatelessWidget {
  const EditBoardGameDetails({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required this.game,
    @required this.bloc,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final Boardgame game;
  final BoardgameBloc bloc;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Form(
      key: _formKey,
      child: Column(children: [
        Center(
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                onChanged: (text) => game.name = text,
                decoration: InputDecoration(
                    labelText: "Name", hintText: "The name of the game."),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {                
                Navigator.of(context).pop();
              },
            ),
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                if (_formKey.currentState.validate() ?? false) {
                  bloc.saveBoardgame(game);
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        ),
      ]),
    ));
  }
}
