import 'package:complete_chat_app_tharwat/core/widgets/const.dart';
import 'package:complete_chat_app_tharwat/features/register/presentation/widgets/register_view_body.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});
  static String id = 'Register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: RegisterViewBody(),
    );
  }
}
