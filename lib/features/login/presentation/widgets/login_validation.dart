import 'package:complete_chat_app_tharwat/core/widgets/custom_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<bool> loginUser(
    BuildContext context, String email, String password) async {
  try {
    // استدعاء Firebase لتسجيل الدخول
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return true; // ✅ تسجيل الدخول ناجح
  } on FirebaseAuthException catch (e) {
    print('Firebase Auth Error Code: ${e.code}'); // Debugging: Print error code

    String errorMessage;
    switch (e.code) {
      case 'user-not-found':
        errorMessage = 'User not found.';
        break;
      case 'wrong-password':
        errorMessage = 'Incorrect password.';
        break;
      case 'network-request-failed':
        errorMessage = 'No internet connection!';
        break;
      case 'invalid-email':
        errorMessage = 'Invalid email address format.';
        break;
      case 'too-many-requests':
        errorMessage = 'Too many login attempts. Try again later.';
        break;
      case 'invalid-credential': // ✅ Handling invalid-credential error
        errorMessage = 'Invalid email or password. Please try again.';
        break;
      default:
        errorMessage = 'An error occurred: ${e.message}';
        break;
    }

    // Show error message
    CustomSnackBar.show(context, errorMessage, color: Colors.red);
  } catch (e) {
    // Handle other errors
    CustomSnackBar.show(context, 'An error occurred: $e', color: Colors.red);
  }

  return false; // ❌ تسجيل الدخول فشل
}
