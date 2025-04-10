import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/resources/jitsi_meet_methods.dart';
import 'package:zoom_clone/utils/colors.dart';
import 'package:zoom_clone/utils/utils.dart';
import 'package:zoom_clone/widgets/meeting_option.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  bool isAudioMuted = true;
  bool isVideoMuted = true;
  final _formKey = GlobalKey<FormState>();
  final _authMethods = AuthMethods();
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();
  late TextEditingController roomIdController;
  late TextEditingController nameController;

  @override
  void initState() {
    roomIdController = TextEditingController();
    nameController = TextEditingController(text: _authMethods.user.displayName);
    super.initState();
  }

  void joinMeeting(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    await _jitsiMeetMethods.joinMeeting(
      roomId: roomIdController.text.trim(),
      isAudioMuted: isAudioMuted,
      isVideoMuted: isVideoMuted,
      context: context,
      startAudioOnly: false,
      name: nameController.text.trim(),
    );
  }

  @override
  void dispose() {
    roomIdController.dispose();
    nameController.dispose();
    // _jitsiMeetMethods.jitsiMeet.;
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Join a Meeting", style: TextStyle(fontSize: 18)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: MyColors.backgroundColor,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: TextFormField(
                controller: roomIdController,
                maxLines: 1,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                validator: Utils.validateRoomId,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: MyColors.secondaryBackgroundColor,
                  border: InputBorder.none,
                  hintText: "Room ID",
                  contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
                ),
              ),
            ),
            SizedBox(
              height: 60,
              child: TextFormField(
                controller: nameController,
                maxLines: 1,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                validator: (string) {
                  if (string == null || string.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: MyColors.secondaryBackgroundColor,
                  border: InputBorder.none,
                  hintText: "Name",
                  contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
                ),
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              onTap: () => joinMeeting(context),
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Text('Join', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 20),
            MeetingOption(
              text: 'Don\'t join a Audio',
              isMute: isAudioMuted,
              onChange: onAudioMuted,
            ),
            MeetingOption(
              text: 'Turn Off My Video',
              isMute: isVideoMuted,
              onChange: onVideoMuted,
            ),
          ],
        ),
      ),
    );
  }

  onAudioMuted(bool val) {
    setState(() {
      isAudioMuted = val;
    });
  }

  onVideoMuted(bool val) {
    setState(() {
      isVideoMuted = val;
    });
  }
}
