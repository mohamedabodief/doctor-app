import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsPage extends StatelessWidget {
  final Map doctor;
  const DetailsPage({super.key, required this.doctor});

  void logout() async {
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
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              logout();
              Navigator.of(context).pushReplacementNamed('/');
            },
            icon: const Icon(Icons.logout, size: 30, color: Colors.white),
          ),
        ],
        title: Text(doctor['name']),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(doctor['imagePath']),
              ),
              const SizedBox(height: 30),
              Text(
                doctor['specialization'],
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Rating',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < doctor['rating'] ? Icons.star : Icons.star_border,
                    color: Colors.yellow,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'experience: ${doctor['experience'].toString()} years',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'reviews (${doctor['reviews'].toString()})',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              const Divider(color: Colors.white70),
              const SizedBox(height: 30),
              Text(
                'Contact : ${doctor['contact'].toString()}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Clinic Location : ${doctor['location']}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Clinic Fees : \$${doctor['clinicfees'].toString()}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 28,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Action to book an appointment
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text(
                    'Book Appointment',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
