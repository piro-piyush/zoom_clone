import 'package:flutter/material.dart';
import 'package:zoom_clone/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CustomButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.buttonColor,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: MyColors.buttonColor),
          ),
        ),
        onPressed: onTap,
        child: Text(text, style: TextStyle(fontSize: 17)),
      ),
    );
  }
}
