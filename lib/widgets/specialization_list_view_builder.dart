import 'package:doctor_app/widgets/card_of_specialization.dart';
import 'package:flutter/material.dart';


class SpecializationListViewBuilder extends StatelessWidget {
  final List items;
  const SpecializationListViewBuilder({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder:
            (context, index) => CardOfSpecialization(
              specialization: items[index]['specialization'],
              imagePath: items[index]['imagePath'],
              cardColor: items[index]['cardColor'],
            ),
      ),
    );
  }
}
