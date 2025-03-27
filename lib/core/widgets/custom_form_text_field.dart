import 'package:flutter/material.dart';

class CustomFormTextField extends StatefulWidget {
  const CustomFormTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.validator,
  });

  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?)? validator;

  @override
  State<CustomFormTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomFormTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword ? obscureText : false,
      validator: widget.validator ?? _defaultValidator,
      keyboardType: widget.hintText == 'Email'
          ? TextInputType.emailAddress
          : widget.hintText == 'Name'
              ? TextInputType.name
              : TextInputType.text,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.white),
        suffixIcon: widget.isPassword
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                ),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  String? _defaultValidator(String? value) {
    if (widget.hintText == 'Name') {
      if (value == null || value.isEmpty) {
        return "Name is required";
      } else if (value.length < 3) {
        return 'Name must be at least 3 characters';
      }
    } else if (widget.hintText == 'Email') {
      if (value == null || value.isEmpty) {
        return 'Email is required';
      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
        return "Invalid email format";
      }
    } else if (widget.hintText == 'Password') {
      if (value == null || value.isEmpty) {
        return "Password is required";
      } else if (value.length < 6) {
        return 'Password must be at least 6 characters';
      }
    }
    return null;
  }
}
