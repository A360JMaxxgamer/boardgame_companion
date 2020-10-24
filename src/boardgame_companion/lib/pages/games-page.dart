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
            onPressed: () => {},
            iconSize: 50.0,
          )
        ],
      ),
    );
  }
}
