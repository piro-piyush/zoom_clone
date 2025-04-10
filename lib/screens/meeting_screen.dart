import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/jitsi_meet_methods.dart';
import 'package:zoom_clone/widgets/home_meeting_button.dart';

import '../utils/utils.dart' show Utils;

class MeetingScreen extends StatelessWidget {
  MeetingScreen({super.key});

  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();

  void newMeeting(BuildContext context) async {
    await _jitsiMeetMethods.createMeeting(
      roomId: Utils.generateNumericRoomId(),
      isAudioMuted: true,
      isVideoMuted: true,
      startAudioOnly: true,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeMeetingButton(
              onTap: () => newMeeting(context),
              icon: IconData(0xe6a8, fontFamily: 'MaterialIcons'),
              text: "New Meeting",
            ),
            HomeMeetingButton(
              onTap: () => Navigator.pushNamed(context, '/video-call'),
              icon: Icons.add_box_rounded,
              text: "Join Meeting",
            ),
            HomeMeetingButton(
              onTap: () {},
              icon: Icons.calendar_today,
              text: "Schedule",
            ),
            HomeMeetingButton(
              onTap: () {},
              icon: Icons.arrow_upward_rounded,
              text: "Share Screen",
            ),
          ],
        ),
        const Expanded(
          child: Center(
            child: Text(
              "Create/Join Meetings with just a click!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
