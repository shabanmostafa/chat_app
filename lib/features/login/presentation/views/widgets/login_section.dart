import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:complete_chat_app_tharwat/core/widgets/custom_button.dart';
import 'package:complete_chat_app_tharwat/core/widgets/custom_form_text_field.dart';
import 'package:complete_chat_app_tharwat/features/login/manager/cubit/login_cubit.dart';

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
          const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Row(
              children: [
                Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          CustomFormTextField(
            hintText: 'Email',
            controller: emailController,
          ),
          const SizedBox(height: 15),
          CustomFormTextField(
            hintText: 'Password',
            controller: passwordController,
            isPassword: true,
          ),
          const SizedBox(height: 10),
          CustomButton(
            color: Colors.white,
            onTap: () {
              if (formKey.currentState!.validate()) {
                context.read<LoginCubit>().login(
                      email: emailController.text,
                      password: passwordController.text,
                    );
              }
            },
            text: 'Login',
          ),
        ],
      ),
    );
  }
}
