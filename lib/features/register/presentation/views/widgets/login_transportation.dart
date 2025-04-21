import 'package:flutter/material.dart';

class LoginTransportation extends StatelessWidget {
  const LoginTransportation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account?   ',
          style: TextStyle(color: Colors.white, fontSize: 13),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Text('Login',
              style: TextStyle(color: Colors.grey, fontSize: 15)),
        ),
      ],
    );
  }
}
