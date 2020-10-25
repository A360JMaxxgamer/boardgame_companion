import 'package:boardgame_companion/model/boardgame.dart';
import 'package:boardgame_companion/model/phases/phase.dart';
import 'package:boardgame_companion/pages/edit-phase-page.dart';
import 'package:boardgame_companion/services/data-service.dart';
import 'package:flutter/material.dart';

class EditGamePage extends StatefulWidget {
  const EditGamePage({Key key, this.boardgame}) : super(key: key);

  @override
  _EditGamePageState createState() => _EditGamePageState(boardgame);

  final Boardgame boardgame;
}

class _EditGamePageState extends State<EditGamePage> {
  final Boardgame boardgame;
  DataService _dataService = DataService();
  int currentStep = 0;

  final _formKey = GlobalKey<FormState>();

  void gotoNextState() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      var submit = currentStep + 1 > 1;
      if (submit) {
        await _dataService.saveBoardgames([boardgame]);
        Navigator.pop(context);
      } else {
        setState(() {
          currentStep++;
        });
      }
    }
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
          Step(
              title: Text("Main info"),
              content: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                        decoration: InputDecoration(
                            labelText: "Name",
                            hintText: "The name of the boardgame."),
                        initialValue: boardgame.name,
                        onSaved: (name) => boardgame.name = name,
                        autovalidateMode: AutovalidateMode.always,
                        validator: (val) => val != null && val.isNotEmpty
                            ? null
                            : "Please enter a name."),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: "Description",
                          hintText: "A short description of the boardgame"),
                      initialValue: boardgame.descpription,
                      onSaved: (descpription) =>
                          boardgame.descpription = descpription,
                      validator: (val) => null,
                    )
                  ],
                ),
              )),
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
                          return EditPhasePage(phase: Phase());
                        }));
                      })
                ],
              ))
        ],
      ),
    );
  }
}
