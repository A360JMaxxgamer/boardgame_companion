import 'package:boardgame_companion/model/phases/phase.dart';
import 'package:flutter/material.dart';

class PhaseGeneral extends StatelessWidget {
  PhaseGeneral({
    Key key,
    @required this.phase,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final Phase phase;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "General",
          textScaleFactor: 1.2,
        ),
        TextFormField(
            key: _formKey,
            decoration: InputDecoration(
                labelText: "Index",
                hintText: "Please enter the index of this phase."),
            initialValue: phase.index.toString(),
            autovalidateMode: AutovalidateMode.always,
            validator: (val) =>
                int.tryParse(val) != null ? null : "Please enter a digit"),
        TextFormField(
            key: _formKey,
            decoration: InputDecoration(
                labelText: "Title",
                hintText: "Please enter the title of this phase."),
            initialValue: phase.title,
            autovalidateMode: AutovalidateMode.always,
            validator: (val) =>
                val != null && val.isNotEmpty ? null : "Please enter a title."),
      ],
    );
  }
}
