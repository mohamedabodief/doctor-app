import 'package:doctor_app/widgets/aleady_have_account.dart';
import 'package:doctor_app/widgets/custom_divider.dart';
import 'package:doctor_app/widgets/custom_form_field.dart';
import 'package:doctor_app/widgets/custom_social_button.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 120),
            Text('Sign Up', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 60),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),

              child: Column(
                children: [
                  CustomFormField(),
                  const SizedBox(height: 25),
                  CustomDivider(),
                  const SizedBox(height: 25),
                  CustomSocialButton(
                    imagePath: 'assets/Logo-google-icon-PNG.png',
                    buttonText: 'Continue with Google',
                    buttonColor: Colors.white,
                    textColor: Colors.black,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 20),
                  CustomSocialButton(
                    imagePath: 'assets/facebooook.png',
                    buttonText: 'Continue with Facebook',
                    buttonColor: Color.fromARGB(255, 71, 108, 187),
                    textColor: Colors.white,
                    onPressed: () {
                      // Handle Facebook login
                    },
                  ),
                  const SizedBox(height: 28),
                  AlreadyHaveAccount(onPressed: () => Navigator.pop(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
