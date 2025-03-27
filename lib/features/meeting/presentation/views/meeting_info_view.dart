import 'package:complete_chat_app_tharwat/features/meeting/presentation/widgets/meeting_info_view_body.dart';
import 'package:flutter/material.dart';

class MeetingInfoView extends StatelessWidget {
  const MeetingInfoView({super.key});
  static String id = 'MeetingInfo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MeetingInfoViewBody(),
    );
  }
}
