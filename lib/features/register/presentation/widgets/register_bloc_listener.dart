import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:complete_chat_app_tharwat/features/home/presentation/widgets/my_chat_list_view_body.dart';
import 'package:complete_chat_app_tharwat/features/register/manager/cubit/register_cubit.dart';
import 'package:complete_chat_app_tharwat/features/register/manager/cubit/register_states.dart';

class RegisterBlocListener extends StatelessWidget {
  final Widget child;

  const RegisterBlocListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(),
      child: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          } else {
            Navigator.of(context, rootNavigator: true).pop();
          }

          if (state is RegisterSuccess) {
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => MyChatListViewBody(currentUserId: user.uid),
                ),
              );
            }
          } else if (state is RegisterFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: child,
      ),
    );
  }
}
