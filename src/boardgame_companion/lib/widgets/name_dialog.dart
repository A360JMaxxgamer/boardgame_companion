import 'package:flutter/material.dart';

class NameDialog extends StatefulWidget {
  final String title;
  final StringCallback onSubmit;

  const NameDialog({Key key, @required this.title, this.onSubmit})
      : super(key: key);
  @override
  _NameDialogState createState() => _NameDialogState(title, onSubmit);
}

class _NameDialogState extends State<NameDialog> {
  final String _title;
  final _formKey = GlobalKey<FormState>();
  final StringCallback _onSubmit;

  String currenText;

  _NameDialogState(this._title, this._onSubmit);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_title),
      actions: [
        IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () => Navigator.of(context).pop(),
        ),
        IconButton(
          icon: Icon(Icons.save),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              if (_onSubmit != null) {
                _onSubmit.call(currenText);
              }
              Navigator.of(context).pop();
            }
          },
        ),
      ],
      content: Form(
        key: _formKey,
        child: TextFormField(
          onChanged: (text) {
            currenText = text;
          },
          initialValue: "",
          validator: (value) {
            if (value.isEmpty) {
              return "Please enter some text";
            }
            return null;
          },
        ),
      ),
    );
  }
}

typedef StringCallback(String text);
