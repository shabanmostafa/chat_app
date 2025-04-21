import 'package:complete_chat_app_tharwat/features/register/presentation/views/register_view.dart';
import 'package:flutter/material.dart';

class RegisterTransportation extends StatelessWidget {
  const RegisterTransportation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Don\'t have an account?   ',
          style: TextStyle(color: Colors.white, fontSize: 13),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RegisterView(),
              ),
            );
          },
          child: const Text('Register',
              style: TextStyle(color: Colors.grey, fontSize: 15)),
        ),
      ],
    );
  }
}
