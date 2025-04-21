import 'package:complete_chat_app_tharwat/core/widgets/idenyify_section.dart';
import 'package:complete_chat_app_tharwat/features/register/presentation/widgets/login_transportation.dart';
import 'package:complete_chat_app_tharwat/features/register/presentation/widgets/register_bloc_listener.dart';
import 'package:complete_chat_app_tharwat/features/register/presentation/widgets/register_section.dart';
import 'package:flutter/material.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

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
            RegisterBlocListener(
              child: RegisterSection(),
            ),
            const SizedBox(
              height: 10,
            ),
            LoginTransportation(),
          ],
        ),
      ),
    );
  }
}
