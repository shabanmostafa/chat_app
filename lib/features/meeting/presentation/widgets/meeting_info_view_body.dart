import 'package:complete_chat_app_tharwat/core/widgets/custom_app_bar.dart';
import 'package:complete_chat_app_tharwat/core/widgets/custom_button.dart';
import 'package:complete_chat_app_tharwat/features/meeting/presentation/widgets/meeting_controller.dart';
import 'package:flutter/material.dart';

class MeetingInfoViewBody extends StatelessWidget {
  final TextEditingController meetingIdController = TextEditingController();

  MeetingInfoViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(text: "Meeting", imageURL: 'assets/images/scholar.png'),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CustomTextField(
              //     //controller: meetingIdController,
              //     labelText: 'Enter Meeting ID'),
              const SizedBox(height: 20),
              CustomButton(
                  color: Color(0xff3A5674),
                  text: 'Create Meeting',
                  onTap: () {
                    MeetingController.createMeeting(
                        context, meetingIdController.text);
                  }),
              const SizedBox(height: 20),
              CustomButton(
                  color: Color(0xff3A5674),
                  text: 'Join Meeting',
                  onTap: () {
                    MeetingController.joinMeeting(
                        context, meetingIdController.text);
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
