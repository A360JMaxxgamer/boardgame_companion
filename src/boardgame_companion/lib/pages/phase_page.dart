import 'package:boardgame_companion/model/boardgame.dart';
import 'package:boardgame_companion/model/phases/phase_step.dart';
import 'package:boardgame_companion/model/phases/phase.dart';
import 'package:boardgame_companion/services/bloc_provider.dart';
import 'package:flutter/material.dart';

class PhasePage extends StatefulWidget {
  final String boardgameId;

  const PhasePage({Key key, @required this.boardgameId}) : super(key: key);
  @override
  _PhasePageState createState() => _PhasePageState(boardgameId);
}

class _PhasePageState extends State<PhasePage> {
  final String boardgameId;

  static const cardHeight = 100.0;

  int currentStep = 0;

  _PhasePageState(this.boardgameId);

  void gotoNextState(List<Phase> phases) {
    setState(() {
      resetCurrentStep(phases);
      currentStep = currentStep + 1 > phases.length - 1 ? 0 : currentStep + 1;
    });
  }

  void gotoPrevState(List<Phase> phases) {
    setState(() {
      resetCurrentStep(phases);
      currentStep = currentStep - 1 < 0 ? phases.length - 1 : currentStep - 1;
    });
  }

  void checkStep(List<Phase> phases, PhaseStep step, bool checked) {
    setState(() {
      step.checked = checked;

      if (phases[currentStep].steps.every((phaseStep) => phaseStep.checked)) {
        gotoNextState(phases);
      }
    });
  }

  void resetCurrentStep(List<Phase> phases) {
    phases[currentStep].steps.forEach((phaseStep) {
      phaseStep.checked = false;
    });
  }

  @override
  Widget build(Object context) {
    final bloc = BlocProvider.of(context).boardgameBloc;
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<Boardgame>(
        stream: bloc.boardgames
            .expand((boardgames) => boardgames)
            .where((boardgame) => boardgame.id == boardgameId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          var game = snapshot.data;
          var phases = game.phases;
          return Column(
            children: <Widget>[
              Expanded(
                child: Stepper(
                  currentStep: currentStep,
                  onStepContinue: () => gotoNextState(phases),
                  onStepCancel: () => gotoPrevState(phases),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: Checkbox(
                                          value: step.checked,
                                          onChanged: (checked) => {
                                            checkStep(phases, step, checked)
                                          },
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: Text(step.title),
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                    visible: step?.details != null &&
                                        step.details.isNotEmpty,
                                    child: IconButton(
                                      alignment: Alignment.centerRight,
                                      icon: Icon(Icons.info),
                                      onPressed: () async {
                                        await showDialog(
                                            context: context,
                                            child: AlertDialog(
                                              content: Container(
                                                padding: EdgeInsets.all(10),
                                                child: Text(step.details),
                                              ),
                                            ));
                                      },
                                    ),
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
          );
        },
      ),
    );
  }
}
