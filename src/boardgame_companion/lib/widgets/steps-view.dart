import 'package:boardgame_companion/model/phases/phase.dart';
import 'package:flutter/material.dart';

class StepsView extends StatelessWidget {
  const StepsView({
    Key key,
    @required this.phase,
  }) : super(key: key);

  final Phase phase;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Steps",
          textScaleFactor: 1.2,
        ),
        Column(
          children: List<Widget>.generate(phase.steps.length, (index) {
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
        IconButton(icon: Icon(Icons.add_circle), onPressed: () => {}),
      ],
    );
  }
}
