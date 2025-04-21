import 'package:complete_chat_app_tharwat/features/login/presentation/manager/cubit/login_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      if (e.code == 'user-not-found') {
        errorMessage = 'User not found.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Incorrect password.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email address.';
      } else if (e.code == 'network-request-failed') {
        errorMessage = 'No internet connection.';
      } else {
        errorMessage = e.message ?? 'Unknown error';
      }

      emit(LoginFailure(errorMessage));
    } catch (e) {
      emit(LoginFailure("Unexpected error occurred"));
    }
  }
}
