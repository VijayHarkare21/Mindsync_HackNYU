import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'pair_earbuds_screen.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/primary_button.dart';
import '../widgets/app_background.dart';
import '../widgets/app_header.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Column(
          children: [
            const AppHeader(), // MindSync Title
            const Spacer(),
            _buildLoginForm(),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        padding: const EdgeInsets.all(20),
        decoration: _boxDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(controller: emailController, label: 'Email'),
            const SizedBox(height: 10),
            CustomTextField(controller: passwordController, label: 'Password', isPassword: true),
            const SizedBox(height: 20),
            PrimaryButton(
              text: "Sign In",
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const PairEarbudsScreen()),
                );
              },
            ),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupScreen())),
              child: const Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white.withOpacity(0.92),
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 2),
      ],
    );
  }
}
