import 'package:complete_chat_app_tharwat/core/widgets/const.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key, required this.text, required this.imageURL, this.iconButton});
  final String text;
  final String imageURL;
  final IconButton? iconButton;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imageURL, width: 50, height: 50),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const Spacer(),
          iconButton ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
