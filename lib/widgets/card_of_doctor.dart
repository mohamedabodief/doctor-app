import 'package:flutter/material.dart';

class CardOfDoctor extends StatelessWidget {
  final String name;
  final String specialization;
  final String location;
  final String imagePath;
  const CardOfDoctor({
    super.key,
    required this.name,
    required this.specialization,
    required this.location,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: Container(
          height: 95,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(50),
            color: Colors.deepPurple.withValues(alpha: .4),
          ),
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
        title: Text(
          name,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              specialization,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.grey[500], size: 16),
                const SizedBox(width: 10),
                Text(
                  location,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
          ],
        ),
        trailing: Icon(Icons.arrow_forward, color: Colors.deepPurple, size: 30),
      ),
    );
  }
}
