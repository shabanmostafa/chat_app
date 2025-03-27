import 'package:complete_chat_app_tharwat/features/meeting/presentation/widgets/video_page.dart';
import 'package:flutter/material.dart';

class MeetingController {
  static void joinMeeting(BuildContext context, String meetingId) {
    if (meetingId.isNotEmpty) {
      debugPrint('Joining Meeting: $meetingId');
      Future.delayed(const Duration(milliseconds: 100), () {
        if (!context.mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoConferencePage(conferenceID: meetingId),
          ),
        );
      });
    }
  }

  static void createMeeting(BuildContext context, String meetingId) {
    debugPrint('Creating Meeting: $meetingId');
    if (meetingId.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (!context.mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoConferencePage(conferenceID: meetingId),
          ),
        );
      });
    }
  }
}
