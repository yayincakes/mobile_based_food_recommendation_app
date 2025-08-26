import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  final _pages = const [
    {'image': 'assets/images/onboarding1.jpg', 'title': 'Eat Healthy'},
    {'image': 'assets/images/onboarding2.jpg', 'title': 'Healthy Recipes'},
    {'image': 'assets/images/onboarding3.jpg', 'title': 'Track Your Health'},
  ];

  @override
  Widget build(BuildContext context) {
    final darkGreen = const Color(0xFF006400);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: _pages.length,
              onPageChanged: (i) => setState(() => _page = i),
              itemBuilder: (_, i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset(_pages[i]['image']!, height: 300),
                  const SizedBox(height: 30),
                  Text(_pages[i]['title']!,
                      style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
                ]),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_pages.length, (i) {
              final active = _page == i;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: active ? 16 : 8, height: 8,
                decoration: BoxDecoration(
                  color: active ? darkGreen : darkGreen.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: darkGreen, minimumSize: const Size.fromHeight(50)),
              onPressed: () {
                if (_page == _pages.length - 1) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                } else {
                  _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                }
              },
              child: Text(_page == _pages.length - 1 ? 'Get Started' : 'Next',
                  style: const TextStyle(color: Colors.white)),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
