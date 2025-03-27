import 'package:complete_chat_app_tharwat/features/chat/presentation/views/chat_view.dart';
import 'package:complete_chat_app_tharwat/features/meeting/presentation/views/meeting_info_view.dart';
import 'package:complete_chat_app_tharwat/features/login/presentation/views/login_view.dart';
import 'package:complete_chat_app_tharwat/features/register/presentation/views/register_view.dart';
import 'package:complete_chat_app_tharwat/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginView.id: (context) => LoginView(),
        RegisterView.id: (context) => RegisterView(),
        MeetingInfoView.id: (context) => MeetingInfoView(),
        ChatView.id: (context) => ChatView(),
      },
      initialRoute: LoginView.id,
    );
  }
}
