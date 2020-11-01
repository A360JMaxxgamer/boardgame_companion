import 'package:boardgame_companion/model/phases/phase.dart';
import 'package:boardgame_companion/services/bloc_provider.dart';
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
    final bloc = BlocProvider.of(context).boardgameBloc;
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "General",
                textScaleFactor: 1.2,
              ),
              TextFormField(
                  decoration: InputDecoration(
                      labelText: "Title",
                      hintText: "Please enter the title of this phase."),
                  initialValue: phase.title,
                  onChanged: (text) => phase.title = text,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (val) => val != null && val.isNotEmpty
                      ? null
                      : "Please enter a title."),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    bloc.savePhases([phase]);
                    Navigator.of(context).pop();
                  }
                }),
          ],
        )
      ],
    );
  }
}
