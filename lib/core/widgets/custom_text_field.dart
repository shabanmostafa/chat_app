import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;

  const CustomTextField({
    super.key,
    required this.labelText,
    //required TextEditingController controller
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      // controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
