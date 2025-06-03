import 'package:doctor_app/firebase_options.dart';
import 'package:doctor_app/pages/details_page.dart';
import 'package:doctor_app/pages/home_page.dart';
import 'package:doctor_app/pages/signup_page.dart';
import 'package:doctor_app/pages/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.deepPurple,
        primaryColor: Colors.deepPurple,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontSize: 14, color: Colors.white),
          bodyLarge: TextStyle(fontSize: 18, color: Colors.white),
          titleLarge: TextStyle(
            fontSize: 46,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      routes: {
        '/': (context) => const SplashPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
        '/details': (context) => const DetailsPage(doctor: {}),
      },
    );
  }
}
