import 'package:boardgame_companion/model/phases/phase-step.dart';
import 'package:boardgame_companion/services/bloc-provider.dart';
import 'package:flutter/material.dart';

class StepDetails extends StatelessWidget {
  StepDetails({
    Key key,
    @required this.step,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final PhaseStep step;
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
                "Details",
                textScaleFactor: 1.2,
              ),
              TextFormField(
                  decoration: InputDecoration(
                      labelText: "Title", hintText: "The title of this step."),
                  initialValue: step.title,
                  onChanged: (text) => step.title = text,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (val) => val != null && val.isNotEmpty
                      ? null
                      : "Please enter a title."),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Details", hintText: "Details of this step"),
                initialValue: step.details,
                onChanged: (text) => step.details = text,
                autovalidateMode: AutovalidateMode.always,
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () {
                  bloc.fetchBoardgames();
                  Navigator.of(context).pop();
                }),
            IconButton(
                icon: Icon(Icons.save),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    bloc.saveSteps([step]);
                    Navigator.of(context).pop();
                  }
                }),
          ],
        )
      ],
    );
  }
}
