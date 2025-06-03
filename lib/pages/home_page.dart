import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/widgets/custom_search_bar.dart';
import 'package:doctor_app/widgets/doctor_list_view_builder.dart';
import 'package:doctor_app/widgets/specialization_list_view_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

List items = [
  {
    'specialization': 'Dental',
    'imagePath': 'assets/dental.png',
    'cardColor': Colors.orange,
  },
  {
    'specialization': 'Cardiology',
    'imagePath': 'assets/cardiology.png',
    'cardColor': Colors.red,
  },
  {
    'specialization': 'Hepatology',
    'imagePath': 'assets/hepatology.png',
    'cardColor': Colors.purple,
  },
  {
    'specialization': 'Brain',
    'imagePath': 'assets/brain.png',
    'cardColor': Colors.green,
  },
];

Future<void> addDoctorsData() async {
  final CollectionReference doctors = FirebaseFirestore.instance.collection(
    'doctors',
  );

  final List<Map<String, dynamic>> doctorsList = [
    {
      'name': 'Dr. John Doe',
      'specialization': 'Cardiologist',
      'location': 'damanhour, Egypt',
      'imagePath': 'assets/1.png',
      'rating': 4.5,
      'experience': 10,
      'reviews': 120,
      'contact': '+20 123 456 7890',
      'clinicfees': 100,
    },
    {
      'name': 'Dr. Jane Smith',
      'specialization': 'Dentist',
      'location': 'cairo, Egypt',
      'imagePath': 'assets/2.png',
      'rating': 4.8,
      'experience': 8,
      'reviews': 90,
      'contact': '+20 987 654 3210',
      'clinicfees': 80,
    },
    {
      'name': 'Dr. Emily Johnson',
      'specialization': 'Hepatologist',
      'location': 'alexandria, Egypt',
      'imagePath': 'assets/3.png',
      'rating': 4.7,
      'experience': 12,
      'reviews': 150,
      'contact': '+20 555 555 5555',
      'clinicfees': 120,
    },
    {
      'name': 'Dr. Michael Brown',
      'specialization': 'Neurologist',
      'location': 'giza, Egypt',
      'imagePath': 'assets/1.png',
      'rating': 4.6,
      'experience': 15,
      'reviews': 180,
      'contact': '+20 777 777 7777',
      'clinicfees': 110,
    },
    {
      'name': 'Dr. Sarah Wilson',
      'specialization': 'Pediatrician',
      'location': 'hurghada, Egypt',
      'imagePath': 'assets/2.png',
      'rating': 4.9,
      'experience': 9,
      'reviews': 70,
      'contact': '+20 888 888 8888',
      'clinicfees': 90,
    },
    {
      'name': 'Dr. David Lee',
      'specialization': 'Orthopedic Surgeon',
      'location': 'sharm el-sheikh, Egypt',
      'imagePath': 'assets/2.png',
      'rating': 4.4,
      'experience': 11,
      'reviews': 130,
      'contact': '+20 999 999 9999',
      'clinicfees': 85,
    },
  ];

  for (var doctor in doctorsList) {
    try {
      final existingDocs =
          await doctors
              .where('name', isEqualTo: doctor['name'])
              .where('contact', isEqualTo: doctor['contact'])
              .get();

      if (existingDocs.docs.isEmpty) {
        await doctors.add(doctor);
        debugPrint('Added ${doctor['name']}');
      } else {
        debugPrint('Skipped ${doctor['name']} (already exists)');
      }
    } catch (e) {
      debugPrint('Failed to add ${doctor['name']}: $e');
    }
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    addDoctorsData();
    super.initState();
  }

  void logoutWithPrefsAndFirebaseAuth() async {
    // sign out with shared preferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSignedIn', false);
    prefs.clear();

    // sign out with firebase
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Let\'s find doctor',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    logoutWithPrefsAndFirebaseAuth();
                    Navigator.of(context).pushReplacementNamed('/');
                  },
                  icon: const Icon(Icons.logout, size: 30, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 10),
            CustomSearchBar(),
            const SizedBox(height: 30),
            SpecializationListViewBuilder(items: items),
            const SizedBox(height: 30),
            Text(
              'Top Doctors',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(child: DoctorListViewBuilder()),
          ],
        ),
      ),
    );
  }
}
