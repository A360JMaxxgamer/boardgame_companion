import 'package:boardgame_companion/db/boardgames_db.dart';
import 'package:boardgame_companion/pages/games-page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BoardgamesDb.initDatabase();
  runApp(SpiritIslandCompanionApp());
}

class SpiritIslandCompanionApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) => GamesPage());
      },
    );
  }
}
