import 'package:boardgame_companion/model/boardgame.dart';
import 'package:boardgame_companion/pages/edit-game-page.dart';
import 'package:flutter/material.dart';

class GamesPage extends StatefulWidget {
  @override
  _GamesPageState createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Games"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(),
          ),
          IconButton(
            alignment: Alignment.centerRight,
            icon: Icon(Icons.add_circle),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute<void>(builder: (BuildContext context) {
                return EditGamePage(
                  boardgame: Boardgame(),
                );
              }));
            },
            iconSize: 50.0,
          )
        ],
      ),
    );
  }
}
