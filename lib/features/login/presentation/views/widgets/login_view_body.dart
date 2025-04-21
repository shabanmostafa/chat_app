import 'package:complete_chat_app_tharwat/core/widgets/idenyify_section.dart';
import 'package:complete_chat_app_tharwat/features/login/presentation/views/widgets/login_bloc_listener.dart';
import 'package:complete_chat_app_tharwat/features/login/presentation/views/widgets/login_section.dart';
import 'package:complete_chat_app_tharwat/features/login/presentation/views/widgets/register_transportation.dart';
import 'package:flutter/material.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView(
          children: [
            IdenyifySection(),
            const SizedBox(
              height: 75,
            ),
            LoginBlocListener(
              child: LoginSection(),
            ),
            const SizedBox(
              height: 10,
            ),
            RegisterTransportation(),
          ],
        ),
      ),
    );
  }
}
