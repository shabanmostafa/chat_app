import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complete_chat_app_tharwat/features/register/manager/cubit/register_states.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> createUser({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(RegisterLoading());
    try {
      UserCredential user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.user!.uid)
          .set({
        'email': email,
        'password': password,
        'name': name,
      });

      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      if (e.code == 'weak-password') {
        errorMessage = "The password provided is too weak!";
      } else if (e.code == 'email-already-in-use') {
        errorMessage = "The account already exists for that email!";
      } else if (e.code == 'invalid-email') {
        errorMessage = "The email address is not valid!";
      } else if (e.code == 'network-request-failed') {
        errorMessage = "No internet connection!";
      } else {
        errorMessage = "Error: ${e.message}";
      }

      emit(RegisterFailure(errorMessage));
    } catch (e) {
      emit(RegisterFailure("Unexpected error occurred"));
    }
  }
}
