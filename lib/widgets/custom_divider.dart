import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 40, height: 1, color: Colors.grey),
        const SizedBox(width: 10),
        const Text('Or', style: TextStyle(fontSize: 18, color: Colors.grey)),
        const SizedBox(width: 10),
        Container(width: 40, height: 1, color: Colors.grey),
      ],
    );
  }
}
