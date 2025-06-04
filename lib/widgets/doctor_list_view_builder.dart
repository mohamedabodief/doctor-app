import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/pages/details_page.dart';
import 'package:doctor_app/widgets/card_of_doctor.dart';
import 'package:flutter/material.dart';

class DoctorListViewBuilder extends StatefulWidget {
  const DoctorListViewBuilder({super.key});

  @override
  State<DoctorListViewBuilder> createState() => _DoctorListViewBuilderState();
}

class _DoctorListViewBuilderState extends State<DoctorListViewBuilder> {
  final CollectionReference doctors = FirebaseFirestore.instance.collection(
    'doctors',
  );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: doctors.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text("there is an error during loading data"),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("there is no data"));
        }

        final List<DocumentSnapshot> docs = snapshot.data!.docs;

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 10),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final doctorData = docs[index].data() as Map<String, dynamic>;

            return InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              focusColor: Colors.transparent,
              onDoubleTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(doctor: doctorData),
                  ),
                );
                debugPrint('Tapped on ${doctorData['name']}');
              },
              child: CardOfDoctor(
                docId: docs[index].id,
                name: doctorData['name'] ?? 'name is missing',
                specialization:
                    doctorData['specialization'] ?? 'specialization is missing',
                location: doctorData['location'] ?? 'location is missing',
                imagePath: doctorData['imagePath'] ?? '',
                contact: doctorData['contact']?.toString() ?? '',
                rating: doctorData['rating'] ?? 0,
                experience: doctorData['experience'] ?? 0,
                reviews: doctorData['reviews'] ?? 0,
                clinicFees: doctorData['clinicfees'] ?? 0,
              ),
            );
          },
        );
      },
    );
  }
}
