import 'package:boardgame_companion/model/phases/phase-step.dart';
import 'package:boardgame_companion/model/phases/phase.dart';
import 'package:flutter/material.dart';

class PhasePage extends StatefulWidget {
  final List<Phase> phases;

  PhasePage({this.phases});

  @override
  _PhasePageState createState() => _PhasePageState(phases: this.phases);
}

class _PhasePageState extends State<PhasePage> {
  final List<Phase> phases;

  static const cardHeight = 100.0;

  int currentStep = 0;

  _PhasePageState({this.phases});

  void gotoNextState() {
    setState(() {
      resetCurrentStep();
      currentStep = currentStep + 1 > phases.length - 1 ? 0 : currentStep + 1;
    });
  }

  void gotoPrevState() {
    setState(() {
      resetCurrentStep();
      currentStep = currentStep - 1 < 0 ? phases.length - 1 : currentStep - 1;
    });
  }

  void checkStep(PhaseStep step, bool checked) {
    setState(() {
      step.checked = checked;

      if (phases[currentStep].steps.every((phaseStep) => phaseStep.checked)) {
        gotoNextState();
      }
    });
  }

  void resetCurrentStep() {
    phases[currentStep].steps.forEach((phaseStep) {
      phaseStep.checked = false;
    });
  }

  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stepper(
              currentStep: currentStep,
              onStepContinue: gotoNextState,
              onStepCancel: gotoPrevState,
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
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Checkbox(
                                      value: step.checked,
                                      onChanged: (checked) =>
                                          {checkStep(step, checked)},
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(step.title),
                                  ),
                                ],
                              ),
                              IconButton(
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
