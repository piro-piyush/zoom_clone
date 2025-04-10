import 'dart:math';

import 'package:flutter/material.dart';

class Utils {
  // Method to show Error Snackbar
  static void showErrorSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: Colors.red, // Error color
        duration: Duration(seconds: 3), // Duration for the snackbar
      ),
    );
  }

  // Method to show Warning Snackbar
  static void showWarningSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: Colors.orange, // Warning color
        duration: Duration(seconds: 3), // Duration for the snackbar
      ),
    );
  }

  // Method to show Success Snackbar
  static void showSuccessSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: Colors.green, // Success color
        duration: Duration(seconds: 3), // Duration for the snackbar
      ),
    );
  }

  static String generateNumericRoomId() {
    final random = Random();
    int length = 9 + random.nextInt(4);
    String roomId =
        List.generate(length, (index) => random.nextInt(10).toString()).join();
    return roomId;
  }

  static String? validateRoomId(String? value) {
    if (value == null || value.isEmpty) {
      return 'Room ID is required';
    }
    final regex = RegExp(r'^\d{9,12}$');
    if (!regex.hasMatch(value)) {
      return 'Room ID must be 9 to 12 digits';
    }
    return null;
  }
}
