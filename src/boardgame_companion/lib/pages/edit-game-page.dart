import 'package:boardgame_companion/model/boardgame.dart';
import 'package:boardgame_companion/pages/edit-phase-page.dart';
import 'package:flutter/material.dart';

class EditGamePage extends StatefulWidget {
  const EditGamePage({Key key, this.boardgame}) : super(key: key);

  @override
  _EditGamePageState createState() => _EditGamePageState(boardgame);

  final Boardgame boardgame;
}

class _EditGamePageState extends State<EditGamePage> {
  final Boardgame boardgame;

  int currentStep = 0;

  void gotoNextState() {
    setState(() {
      currentStep++;
      if (currentStep > 1) {
        Navigator.pop(context);
      }
    });
  }

  void gotoPrevState() {
    setState(() {
      currentStep--;
      if (currentStep < 0) {
        Navigator.pop(context);
      }
    });
  }

  _EditGamePageState(this.boardgame);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit game"),
      ),
      body: Stepper(
        currentStep: currentStep,
        onStepContinue: gotoNextState,
        onStepCancel: gotoPrevState,
        steps: [
          Step(title: Text("Main info"), content: Column()),
          Step(
              title: Text("Phases"),
              content: Stack(
                children: [
                  Column(
                      children: List<Widget>.generate(boardgame.phases.length,
                          (index) {
                    return Row();
                  })),
                  IconButton(
                      alignment: Alignment.centerRight,
                      icon: Icon(Icons.add_circle),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute<void>(
                            builder: (BuildContext context) {
                          return EditPhasePage();
                        }));
                      })
                ],
              ))
        ],
      ),
    );
  }
}
