import 'package:complete_chat_app_tharwat/core/widgets/const.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final IconButton? suffixIcon;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.suffixIcon,
    //required TextEditingController controller
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      // controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: primaryColor, width: 1),
        ),
      ),
    );
  }
}
