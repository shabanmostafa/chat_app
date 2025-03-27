import 'package:complete_chat_app_tharwat/core/widgets/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void createUser(BuildContext context, String email, String password) async {
  try {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    CustomSnackBar.show(context, 'Welcome, ${user.user!.email}',
        color: Colors.green);

    print("the user is created: ${user.user!.email}");
  } on FirebaseAuthException catch (e) {
    String errorMessage;

    if (e.code == 'weak-password') {
      errorMessage = "the password provided is too weak!";
    } else if (e.code == 'email-already-in-use') {
      errorMessage = "the account already exists for that email!";
    } else if (e.code == 'invalid-email') {
      errorMessage = "the email address is not valid!";
    } else if (e.code == 'network-request-failed') {
      errorMessage = "No internet connection!";
    } else {
      errorMessage = "error: ${e.message}";
    }

    // عرض رسالة الخطأ في SnackBar
    CustomSnackBar.show(context, errorMessage, color: Colors.red);

    print("خطأ: ${e.message}");
  } catch (e) {
    // التعامل مع أي خطأ غير متوقع
    CustomSnackBar.show(context, "Unexpected Error", color: Colors.red);

    print('unexpected Error');
  }
}
