import 'package:flutter/material.dart';
import 'package:spirit_island_companion/phases/phase-step.dart';
import 'package:spirit_island_companion/phases/phase.dart';

class PhasePage extends StatefulWidget {
  final List<Phase> phases;

  PhasePage({this.phases});

  @override
  _PhasePageState createState() => _PhasePageState(phases: this.phases);
}

class _PhasePageState extends State<PhasePage> {
  final List<Phase> phases;

  static const cardHeight = 100.0;

  _PhasePageState({this.phases});

  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stepper(
              steps: List<Step>.generate(phases.length, (index) {
                var phase = phases[index];
                return Step(
                  title: Text(phase.title),
                  content: Column(
                    children:
                        List<Widget>.generate(phase.steps.length, (index) {
                      var step = phase.steps[index];
                      return SizedBox(
                        height: cardHeight,
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(step.title),
                              ),
                              IconButton(
                                alignment: Alignment.centerRight,
                                icon: Icon(Icons.info),
                                onPressed: () => {},
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}
