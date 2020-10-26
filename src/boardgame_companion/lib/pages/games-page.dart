import 'package:boardgame_companion/model/boardgame.dart';
import 'package:boardgame_companion/pages/edit-game-page.dart';
import 'package:boardgame_companion/services/data-service.dart';
import 'package:flutter/material.dart';

class GamesPage extends StatefulWidget {
  @override
  _GamesPageState createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  DataService _dataService = DataService();

  @override
  void initState() {
    super.initState();
    initList();
  }

  void initList() async {
    await _dataService.fetchBoardgames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Games"),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add_circle),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute<void>(builder: (BuildContext context) {
                return EditGamePage(
                  boardgame: Boardgame(),
                );
              }));
            }),
        body: StreamBuilder<List<Boardgame>>(
          stream: _dataService.dataObservable,
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
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [Text(game.name)],
                    ),
                  ),
                );
              }),
            );
          },
        ));
  }
}
