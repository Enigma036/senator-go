import 'package:flutter/material.dart';

// A simple dialog widget to display location-related messages
class LocationDialog extends StatelessWidget {
  // Constructor with optional title and text parameters
  const LocationDialog({super.key, this.title, this.text});

  // The title of the dialog
  final title;
  // The content text of the dialog
  final text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // Sets the dialog title
      title: Text(title),
      // Sets the dialog content
      content: Text(text),
      // Dialog actions (e.g., buttons)
      actions: <Widget>[
        // OK button to close the dialog
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK', style: TextStyle(color: Color(0xff003876))),
        ),
      ],
    );
  }
}
