import 'package:boardgame_companion/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';

class ItemActionBar extends StatelessWidget {
  final VoidCallback onEdit;

  final VoidCallback onDelete;

  const ItemActionBar({Key key, this.onEdit, this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
            visible: onEdit != null,
            child: IconButton(
                icon: Icon(Icons.edit), onPressed: () => onEdit.call())),
        Visibility(
          visible: onDelete != null,
          child: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                  context: context,
                  child: ConfirmationDialog(
                      message: "Do you really wan to delete this item?",
                      onConfirmed: () => onDelete.call()));
            },
          ),
        )
      ],
    );
  }
}
