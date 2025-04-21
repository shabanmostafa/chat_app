import 'package:complete_chat_app_tharwat/core/widgets/custom_button.dart';
import 'package:complete_chat_app_tharwat/core/widgets/custom_form_text_field.dart';
import 'package:complete_chat_app_tharwat/features/register/presentation/manager/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterSection extends StatefulWidget {
  const RegisterSection({super.key});

  @override
  State<RegisterSection> createState() => _RegisterSectionState();
}

class _RegisterSectionState extends State<RegisterSection> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
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
                  'Register',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          CustomFormTextField(
            hintText: 'Name',
            controller: nameController,
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
                context.read<RegisterCubit>().createUser(
                      email: emailController.text,
                      password: passwordController.text,
                      name: nameController.text,
                    );
              }
            },
            text: 'Register',
          ),
        ],
      ),
    );
  }
}
