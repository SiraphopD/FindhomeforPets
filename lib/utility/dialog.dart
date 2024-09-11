import 'package:findhomeforpets/utility/my_style.dart';
import 'package:flutter/material.dart';

Future<Null> normailDialog(
    BuildContext context, String title, String message) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: ListTile(
        title: Text(
          title,
          style: MyStyle().redStyle(),
        ),
        subtitle: Text(
          message,
          style: MyStyle().darkStyle(),
        ),
      ),
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('OK'),
        ),
      ],
    ),
  );
}
