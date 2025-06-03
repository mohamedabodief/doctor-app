import 'package:doctor_app/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomFormField extends StatefulWidget {
  const CustomFormField({super.key});

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  final formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String confirmPassword = '';
  final TextEditingController _passwordController = TextEditingController();
  bool isChecked = false;

  void signUpWithPrefsAndFirebaseAuth() async {
    // sign up with shared preferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setBool('isSignedIn', true);
    debugPrint('prefs.get(email): ${prefs.get('email')}');
    debugPrint('prefs.get(password): ${prefs.get('password')}');
    debugPrint('prefs.get(isSignedIn): ${prefs.get('isSignedIn')}');

    // sign up with firebase
    try {
      // ignore: unused_local_variable
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      }
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            style: TextStyle(
              color: Colors.black.withValues(alpha: .6),
              fontSize: 20,
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your Email';
              }
              if (!RegExp(
                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
              ).hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              if (value.length < 3) {
                return 'Email must be at least 3 characters long';
              }
              if (value.length > 50) {
                return 'Email must be less than 50 characters long';
              }
              if (value.contains(' ')) {
                return 'Email cannot contain spaces';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(16),
              labelText: 'Email',
              filled: true,
              fillColor: Colors.grey.withValues(alpha: .3),
              labelStyle: TextStyle(
                color: Colors.black.withValues(alpha: .6),
                fontSize: 20,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            style: TextStyle(
              color: Colors.black.withValues(alpha: .6),
              fontSize: 20,
            ),
            keyboardType: TextInputType.visiblePassword,
            controller: _passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              if (value.length > 20) {
                return 'Password must be less than 20 characters long';
              }
              if (value.contains(' ')) {
                return 'Password cannot contain spaces';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
            obscureText: obscurePassword,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(16),
              labelText: 'Enter Password',
              filled: true,
              fillColor: Colors.grey.withValues(alpha: .3),
              labelStyle: TextStyle(
                color: Colors.black.withValues(alpha: .6),
                fontSize: 20,
              ),
              suffixIcon: IconButton(
                onPressed:
                    () => setState(() => obscurePassword = !obscurePassword),
                icon: Icon(
                  obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            style: TextStyle(
              color: Colors.black.withValues(alpha: .6),
              fontSize: 20,
            ),
            keyboardType: TextInputType.visiblePassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != password) {
                return 'Passwords do not match';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              if (value.length > 20) {
                return 'Password must be less than 20 characters long';
              }
              if (value.contains(' ')) {
                return 'Password cannot contain spaces';
              }
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) {
              setState(() {
                confirmPassword = value;
              });
            },
            obscureText: obscureConfirmPassword,
            onSaved: (value) {
              setState(() {
                confirmPassword = value!;
              });
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(16),
              labelText: 'Enter Confirm Password',
              filled: true,
              fillColor: Colors.grey.withValues(alpha: .3),
              labelStyle: TextStyle(
                color: Colors.black.withValues(alpha: .6),
                fontSize: 20,
              ),

              suffixIcon: IconButton(
                onPressed:
                    () => setState(
                      () => obscureConfirmPassword = !obscureConfirmPassword,
                    ),
                icon: Icon(
                  obscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
                activeColor: Colors.blue,
                checkColor: Colors.white,
              ),
              const Text(
                'I agree to the ',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),

              InkWell(
                child: const Text(
                  'Terms and Conditions',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate() && isChecked) {
                // Handle successful signup
                signUpWithPrefsAndFirebaseAuth();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(
                      'Signup Successful',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: Text(
                      'Please agree to the terms and conditions',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
