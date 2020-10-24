import 'package:boardgame_companion/model/phases/phase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditPhasePage extends StatefulWidget {
  final Phase phase;

  const EditPhasePage({Key key, this.phase}) : super(key: key);

  _EditPhasePageState createState() => _EditPhasePageState(phase);
}

class _EditPhasePageState extends State<EditPhasePage> {
  final Phase phase;

  _EditPhasePageState(this.phase);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit phase"),
        ),
        body: Flex(
          direction: Axis.vertical,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Expanded(
                child: Column(
                  children: [
                    Text(
                      "General",
                      textScaleFactor: 1.2,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                            labelText: "Index",
                            hintText: "Please enter the index of this phase."),
                        initialValue: phase.index.toString(),
                        autovalidateMode: AutovalidateMode.always,
                        validator: (val) => int.tryParse(val) != null
                            ? null
                            : "Please enter a digit"),
                    TextFormField(
                        decoration: InputDecoration(
                            labelText: "Title",
                            hintText: "Please enter the title of this phase."),
                        initialValue: phase.title,
                        autovalidateMode: AutovalidateMode.always,
                        validator: (val) => val != null && val.isNotEmpty
                            ? null
                            : "Please enter a title."),
                    Text(
                      "Steps",
                      textScaleFactor: 1.2,
                    ),
                    Column(
                      children:
                          List<Widget>.generate(phase.steps.length, (index) {
                        var step = phase.steps[index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(step.title),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () => {},
                            )
                          ],
                        );
                      }),
                    ),
                    IconButton(
                        icon: Icon(Icons.add_circle), onPressed: () => {}),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
