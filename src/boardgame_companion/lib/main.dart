import 'package:boardgame_companion/pages/games_page.dart';
import 'package:boardgame_companion/services/bloc_provider.dart';
import 'package:boardgame_companion/services/boardgame_bloc.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BlocProvider(
    boardgameBloc: BoardgameBloc(),
    child: BoardgameCompanionApp(),
  ));
}

class BoardgameCompanionApp extends StatelessWidget {
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
