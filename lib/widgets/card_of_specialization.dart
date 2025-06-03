import 'package:flutter/material.dart';

class CardOfSpecialization extends StatelessWidget {
  final String specialization;
  final String imagePath;
  final Color cardColor;
  final Color textColor = Colors.white;
  const CardOfSpecialization({
    super.key,
    required this.specialization,
    required this.imagePath,
    required this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: () {
        // Handle tap event, e.g., navigate to a new page
        // ignore: avoid_print
        debugPrint('Tapped on $specialization');
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        width: 150,
        height: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: cardColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(imagePath, width: 90, height: 90),
            const SizedBox(height: 10),
            Text(
              specialization,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
