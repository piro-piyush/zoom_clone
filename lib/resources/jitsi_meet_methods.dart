import 'package:flutter/material.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/resources/firestore_methods.dart';
import 'package:zoom_clone/utils/utils.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  final FirestoreMethods _firestoreMethods = FirestoreMethods();
  final jitsiMeet = JitsiMeet();

  Future<void> createMeeting({
    required String roomId,
    required bool isAudioMuted,
    required bool isVideoMuted,
    required bool startAudioOnly,
    String? resolution =
        "hd", // You can set this to "low", "medium", "high", "hd", etc.
    required BuildContext context,
  }) async {
    try {
      var options = JitsiMeetConferenceOptions(
        room: roomId,
        configOverrides: {
          "startWithAudioMuted": isAudioMuted,
          "startWithVideoMuted": isVideoMuted,
          "startAudioOnly": startAudioOnly,
          "subject": "Jitsi with Flutter",
        },
        featureFlags: {
          "unsaferoomwarning.enabled": false,
          'resolution': resolution,
        },
        userInfo: JitsiMeetUserInfo(
          displayName: _authMethods.user.displayName,
          email: _authMethods.user.email,
          avatar: _authMethods.user.photoURL,
        ),
      );
      // Start meeting
      await jitsiMeet.join(options);
       _firestoreMethods.addToMeetingHistory(roomId);
    } catch (e) {
      if (context.mounted) {
        Utils.showErrorSnackBar(context, e.toString());
      }
    }
  }

  Future<void> joinMeeting({
    required String roomId,
    required bool isAudioMuted,
    required bool isVideoMuted,
    required BuildContext context,
    required bool startAudioOnly,
    required String name,
    String? resolution = "hd",
  }) async {
    try {
      var options = JitsiMeetConferenceOptions(
        room: roomId,
        configOverrides: {
          "startWithAudioMuted": isAudioMuted,
          "startWithVideoMuted": isVideoMuted,
          "startAudioOnly": startAudioOnly,
          "subject": "Jitsi with Flutter",
        },
        featureFlags: {
          "unsaferoomwarning.enabled": false,
          'resolution': resolution,
        },
        userInfo: JitsiMeetUserInfo(
          displayName: name,
          email: _authMethods.user.email,
          avatar: _authMethods.user.photoURL,
        ),
      );
      // Start meeting
      await jitsiMeet.join(options);
      _firestoreMethods.addToMeetingHistory(roomId);
    } catch (e) {
      if (context.mounted) {
        Utils.showErrorSnackBar(context, e.toString());
      }
    }
  }
}
