import 'package:complete_chat_app_tharwat/core/widgets/const.dart';
import 'package:complete_chat_app_tharwat/features/login/presentation/widgets/login_view_body.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static String id = 'Login_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: LoginViewBody(),
    );
  }
}
