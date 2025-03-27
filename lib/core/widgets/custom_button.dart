import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.color});
  final VoidCallback? onTap;
  final String? text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(20)),
        height: 60,
        width: double.infinity,
        child: Center(child: Text(text!)),
      ),
    );
  }
}
