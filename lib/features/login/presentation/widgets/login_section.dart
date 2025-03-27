import 'package:complete_chat_app_tharwat/core/widgets/custom_button.dart';
import 'package:complete_chat_app_tharwat/core/widgets/custom_form_text_field.dart';
import 'package:complete_chat_app_tharwat/features/chat/presentation/views/chat_view.dart';
import 'package:complete_chat_app_tharwat/features/login/presentation/widgets/login_validation.dart';
import 'package:flutter/material.dart';

class LoginSection extends StatefulWidget {
  const LoginSection({super.key});

  @override
  State<LoginSection> createState() => _LoginSectionState();
}

class _LoginSectionState extends State<LoginSection> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              children: const [
                Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Email Field
          CustomFormTextField(
            hintText: 'Email',
            controller: emailController,
          ),
          const SizedBox(height: 15),

          // Password Field
          CustomFormTextField(
            hintText: 'Password',
            controller: passwordController,
            isPassword: true,
          ),
          const SizedBox(height: 10),

          // Login Button
          CustomButton(
            color: Colors.white,
            onTap: () async {
              if (formKey.currentState!.validate()) {
                bool isSuccess = await loginUser(
                    context, emailController.text, passwordController.text);
                if (isSuccess) {
                  Navigator.of(context)
                      .pushNamed(ChatView.id, arguments: emailController.text);
                }
              }
            },
            text: 'Login',
          ),
        ],
      ),
    );
  }
}
