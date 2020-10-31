import 'package:boardgame_companion/services/boardgame_bloc.dart';
import 'package:flutter/material.dart';

class BlocProvider extends InheritedWidget {
  final BoardgameBloc boardgameBloc;

  const BlocProvider({Key key, @required Widget child, this.boardgameBloc})
      : assert(child != null),
        super(key: key, child: child);

  static BlocProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BlocProvider>();
  }

  @override
  bool updateShouldNotify(BlocProvider old) {
    return true;
  }
}
