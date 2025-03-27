import 'package:complete_chat_app_tharwat/core/widgets/custom_button.dart';
import 'package:complete_chat_app_tharwat/core/widgets/custom_form_text_field.dart';
import 'package:complete_chat_app_tharwat/features/register/presentation/widgets/register_validation.dart';
import 'package:flutter/material.dart';

class RegisterSection extends StatefulWidget {
  RegisterSection({super.key});

  @override
  State<RegisterSection> createState() => _RegisterSectionState();
}

class _RegisterSectionState extends State<RegisterSection> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // إضافة Controllers
  final TextEditingController nameController = TextEditingController();
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
                  'Register',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Name Field
          CustomFormTextField(
            hintText: 'Name',
            controller: nameController,
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
            isPassword: true, // حقل كلمة مرور
          ),
          const SizedBox(height: 10),

          // Register Button
          CustomButton(
            color: Colors.white,
            onTap: () {
              if (formKey.currentState!.validate()) {
                createUser(
                    context, emailController.text, passwordController.text);
                Navigator.pop(context);
              }
            },
            text: 'Register',
          ),
        ],
      ),
    );
  }
}
