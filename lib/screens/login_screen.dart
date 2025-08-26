import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final darkGreen = const Color(0xFF006400);
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: darkGreen,
        centerTitle: true,
        title: Text('Login', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text('FitMeal',
                style: GoogleFonts.pacifico(fontSize: 36, color: darkGreen)),
            ),
            const SizedBox(height: 48),

            // Student Number
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person, color: darkGreen),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 16),

            // Password
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock, color: darkGreen),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 24),

            // Login -> Create Plan (replacement)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: darkGreen,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                // TODO: Validate credentials as needed.
                // After success, continue the planned flow:
                Navigator.pushReplacementNamed(context, '/create_plan');
              },
              child: Text('Login',
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
            ),

            const SizedBox(height: 12),
            TextButton(
              onPressed: () {}, // TODO: Forgot password
              child: Text('Forgot Password?', style: TextStyle(color: darkGreen)),
            ),
            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {}, // TODO: Sign up
                  child: Text('Sign Up',
                    style: TextStyle(color: darkGreen, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
