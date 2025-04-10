import 'package:flutter/material.dart';
import 'package:zoom_clone/utils/colors.dart';

class HomeMeetingButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String text;

  const HomeMeetingButton({super.key, required this.onTap, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        spacing: 10,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: MyColors.buttonColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black.withValues(alpha: 0.06),
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon,color: MyColors.light,size: 30,),
          ),
          Text(text, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
