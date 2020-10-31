import 'package:flutter/material.dart';

class BgCard extends StatelessWidget {
  final Widget child;

  const BgCard({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: child,
      ),
    ));
  }
}
