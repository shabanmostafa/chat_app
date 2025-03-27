import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';

class VideoConferencePage extends StatelessWidget {
  final String conferenceID;

  const VideoConferencePage({
    Key? key,
    required this.conferenceID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // جلب المستخدم الحالي من Firebase
    User? user = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
        appID: 200476770,
        appSign:
            'ca727261841a4b4c7c8bcf0fbf7f0004276c0b9b6511a95f20701b07954730a8',
        userID: user?.uid ?? 'unknown_user', // ID المستخدم من Firebase
        userName: user?.displayName ??
            user?.email ??
            'Guest', // اسم المستخدم أو البريد الإلكتروني
        conferenceID: conferenceID,
        config: ZegoUIKitPrebuiltVideoConferenceConfig(),
      ),
    );
  }
}
