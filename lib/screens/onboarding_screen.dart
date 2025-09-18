import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> 
    with SingleTickerProviderStateMixin {
  final _controller = PageController();
  int _page = 0;
  bool _isAnimating = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final _pages = const [
    OnboardingPageData(
      title: 'Eat Healthy',
      subtitle: 'Discover personalized meal plans tailored to your health conditions and dietary goals',
      imagePath: 'assets/images/onboarding1.jpg',
      color: Color(0xFF4CAF50),
    ),
    OnboardingPageData(
      title: 'Healthy Recipes', 
      subtitle: 'Access hundreds of nutritious recipes with detailed nutritional information and cooking instructions',
      imagePath: 'assets/images/onboarding2.jpg',
      color: Color(0xFF2196F3),
    ),
    OnboardingPageData(
      title: 'Track Your Health',
      subtitle: 'Monitor your daily nutrition, track progress, and achieve your wellness goals with ease',
      imagePath: 'assets/images/onboarding3.jpg',
      color: Color(0xFFFF9800),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  void _setupAnimation() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _nextPage() async {
    if (_isAnimating) return;
    
    setState(() => _isAnimating = true);
    
    if (_page == _pages.length - 1) {
      await _navigateToLogin();
    } else {
      await _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    }
    
    if (mounted) {
      setState(() => _isAnimating = false);
    }
  }

  Future<void> _previousPage() async {
    if (_isAnimating || _page == 0) return;
    
    setState(() => _isAnimating = true);
    
    await _controller.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
    
    if (mounted) {
      setState(() => _isAnimating = false);
    }
  }

  Future<void> _navigateToLogin() async {
    // Add a slight delay for better UX
    await Future.delayed(const Duration(milliseconds: 200));
    
    if (!mounted) return;
    
    Navigator.pushReplacement(
      context, 
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final darkGreen = const Color(0xFF006400);
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SafeArea(
          child: Column(
            children: [
              // Skip button
              Padding(
                padding: const EdgeInsets.only(top: 16, right: 16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: _navigateToLogin,
                    child: Text(
                      'Skip',
                      style: GoogleFonts.poppins(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              
              // Page content
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (i) => setState(() => _page = i),
                  itemBuilder: (_, i) => _buildPage(_pages[i]),
                ),
              ),
              
              // Bottom section
              Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // Page indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_pages.length, (i) {
                        final isActive = _page == i;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: isActive ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: isActive ? darkGreen : darkGreen.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Navigation buttons
                    Row(
                      children: [
                        // Back button
                        if (_page > 0)
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: _isAnimating ? null : _previousPage,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: darkGreen,
                                side: BorderSide(color: darkGreen),
                                minimumSize: const Size.fromHeight(52),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              icon: const Icon(Icons.arrow_back),
                              label: Text(
                                'Back',
                                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        
                        if (_page > 0) const SizedBox(width: 16),
                        
                        // Next/Get Started button
                        Expanded(
                          flex: _page > 0 ? 1 : 1,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: darkGreen,
                              foregroundColor: Colors.white,
                              minimumSize: const Size.fromHeight(52),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: _isAnimating ? null : _nextPage,
                            icon: _isAnimating
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                : Icon(_page == _pages.length - 1 
                                    ? Icons.check 
                                    : Icons.arrow_forward),
                            label: Text(
                              _page == _pages.length - 1 ? 'Get Started' : 'Next',
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPageData pageData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Show image only, no background
          Image.asset(
            pageData.imagePath,
            width: 220,
            height: 220,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.broken_image,
              size: 80,
              color: pageData.color,
            ),
          ),
          const SizedBox(height: 32),
          // Title
          Text(
            pageData.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2E2E2E),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          // Subtitle
          Text(
            pageData.subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          _buildFeatureHighlights(_page),
        ],
      ),
    );
  }

  Widget _buildFeatureHighlights(int pageIndex) {
    List<String> features;
    
    switch (pageIndex) {
      case 0:
        features = ['Personalized Plans', 'Disease-Specific', 'Expert Approved'];
        break;
      case 1:
        features = ['500+ Recipes', 'Nutritional Info', 'Easy Instructions'];
        break;
      case 2:
        features = ['Daily Tracking', 'Progress Charts', 'Goal Setting'];
        break;
      default:
        features = [];
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: features.map((feature) => _buildFeatureChip(feature)).toList(),
    );
  }

  Widget _buildFeatureChip(String feature) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF006400).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF006400).withOpacity(0.3),
        ),
      ),
      child: Text(
        feature,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF006400),
        ),
      ),
    );
  }
}

class OnboardingPageData {
  final String title;
  final String subtitle;
  final String imagePath;
  final Color color;

  const OnboardingPageData({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.color,
  });
}