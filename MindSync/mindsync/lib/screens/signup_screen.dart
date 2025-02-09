import 'package:flutter/material.dart';
import 'pair_earbuds_screen.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/primary_button.dart';
import '../widgets/app_background.dart';
import '../widgets/app_header.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Column(
          children: [
            const AppHeader(), // MindSync Title
            const Spacer(),
            _buildSignupForm(),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildSignupForm() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        padding: const EdgeInsets.all(20),
        decoration: _boxDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(controller: nameController, label: 'Name'),
            const SizedBox(height: 10),
            CustomTextField(controller: emailController, label: 'Email'),
            const SizedBox(height: 10),
            CustomTextField(controller: passwordController, label: 'Password', isPassword: true),
            const SizedBox(height: 10),
            CustomTextField(controller: confirmPasswordController, label: 'Confirm Password', isPassword: true),
            const SizedBox(height: 15),
            _buildToggleSwitch(),
            const SizedBox(height: 20),
            PrimaryButton(
              text: "Sign Up",
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const PairEarbudsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Allow us to use your data?"),
        Switch(
          value: agreeToTerms,
          onChanged: (value) => setState(() => agreeToTerms = value),
          activeColor: Colors.blueAccent,
        ),
      ],
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white.withOpacity(0.92),
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 2)],
    );
  }
}
