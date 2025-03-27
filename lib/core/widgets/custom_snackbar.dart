import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(BuildContext context, String errorMessage,
      {Color color = Colors.green}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: color,
      ),
    );
  }
}
