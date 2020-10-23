import 'package:flutter/material.dart';
import 'package:spirit_island_companion/pages/phase-page.dart';
import 'package:spirit_island_companion/phases/phase-factory.dart';

void main() {
  runApp(SpiritIslandCompanionApp());
}

class SpiritIslandCompanionApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
            builder: (context) =>
                PhasePage(phases: PhaseFactory.createPhases()));
      },
    );
  }
}
