import 'package:flutter/material.dart';

class CustomSocialButton extends StatelessWidget {
  final String imagePath;
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;
  const CustomSocialButton({
    super.key,
    required this.imagePath,
    required this.buttonText,
    required this.onPressed,
    required this.buttonColor, required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
          side: BorderSide(color: Colors.black, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, width: 25),
          const SizedBox(width: 10),
          Text(buttonText, style: TextStyle(fontSize: 18, color: textColor)),
        ],
      ),
    );
  }
}
