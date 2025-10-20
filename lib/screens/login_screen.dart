import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../services/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> 
    with SingleTickerProviderStateMixin {
  final Color darkGreen = const Color(0xFF006400);
  final Color lightGreen = const Color(0xFFE8F5E8);
  
  final _loginFormKey = GlobalKey<FormState>();
  final _signupFormKey = GlobalKey<FormState>();
  
  // Login controllers
  final _loginUsernameController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  
  // Signup controllers
  final _signupUsernameController = TextEditingController();
  final _signupEmailController = TextEditingController();
  final _signupPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _fullNameController = TextEditingController();
  
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  bool _rememberMe = false;
  bool _isSignUpMode = false;
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _loadRememberedCredentials();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    
    _animationController.forward();
  }

  void _loadRememberedCredentials() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedUsername = prefs.getString('remembered_username');
      final savedRememberMe = prefs.getBool('remember_me') ?? false;
      
      if (savedUsername != null && savedRememberMe) {
        setState(() {
          _loginUsernameController.text = savedUsername;
          _rememberMe = savedRememberMe;
        });
      }
    } catch (e) {
      debugPrint('Error loading remembered credentials: $e');
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _loginUsernameController.dispose();
    _loginPasswordController.dispose();
    _signupUsernameController.dispose();
    _signupEmailController.dispose();
    _signupPasswordController.dispose();
    _confirmPasswordController.dispose();
    _fullNameController.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  // Validation methods
  String? _validateUsername(String? value, {bool isSignup = false}) {
    if (value?.trim().isEmpty ?? true) {
      return 'Please enter your username';
    }
    
    if (value!.length < 3) {
      return 'Username must be at least 3 characters';
    }
    
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return 'Username can only contain letters, numbers, and underscores';
    }
    
    return null;
  }

  String? _validateEmail(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'Please enter your email';
    }
    
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }

  String? _validatePassword(String? value, {bool isSignup = false}) {
    if (value?.trim().isEmpty ?? true) {
      return 'Please enter your password';
    }
    
    if (isSignup && value!.length < 8) {
      return 'Password must be at least 8 characters';
    } else if (!isSignup && value!.length < 6) {
      return 'Password must be at least 6 characters';
    }
    
    if (isSignup) {
      if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$').hasMatch(value!)) {
        return 'Password must contain uppercase, lowercase, and number';
      }
    }
    
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'Please confirm your password';
    }
    
    if (value != _signupPasswordController.text) {
      return 'Passwords do not match';
    }
    
    return null;
  }

  String? _validateFullName(String? value) {
    if (value?.trim().isEmpty ?? true) {
      return 'Please enter your full name';
    }
    
    if (value!.trim().length < 2) {
      return 'Full name must be at least 2 characters';
    }
    
    return null;
  }

  // Authentication methods
  Future<Map<String, dynamic>?> _getStoredUsers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersJson = prefs.getString('registered_users');
      if (usersJson != null) {
        return json.decode(usersJson) as Map<String, dynamic>;
      }
      return {};
    } catch (e) {
      debugPrint('Error getting stored users: $e');
      return {};
    }
  }

  Future<void> _saveUser(String username, Map<String, dynamic> userData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final users = await _getStoredUsers() ?? {};
      users[username] = userData;
      await prefs.setString('registered_users', json.encode(users));
    } catch (e) {
      debugPrint('Error saving user: $e');
      throw Exception('Failed to save user data');
    }
  }

  Future<void> _handleLogin() async {
    if (_isLoading) return;
    
    FocusScope.of(context).unfocus();
    
    if (!_loginFormKey.currentState!.validate()) {
      _showError('Please fix the errors above');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final email = _loginUsernameController.text.trim();
      final password = _loginPasswordController.text;
      
      // Try API login first
      final result = await ApiService.login(
        email,
        password,
      );
      
      if (result['success']) {
        final userData = result['data']['user'];
        await _handleSuccessfulLogin(
          userData['name'] ?? userData['email'],
          userData: userData,
          isAdmin: userData['is_admin'] ?? false,
        );
        return;
      }
      
      // Fallback to local admin check
      if (email == 'admin' && password == 'password123') {
        await _handleSuccessfulLogin(email, isAdmin: true);
        return;
      }
      
      // Fallback to local users
      final users = await _getStoredUsers();
      if (users != null && users.containsKey(email)) {
        final userData = users[email] as Map<String, dynamic>;
        if (userData['password'] == password) {
          await _handleSuccessfulLogin(email, userData: userData);
          return;
        }
      }
      
      throw Exception(result['error'] ?? 'Invalid credentials');
    } catch (e) {
      _showError(_getErrorMessage(e));
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleSignUp() async {
    if (_isLoading) return;
    
    FocusScope.of(context).unfocus();
    
    if (!_signupFormKey.currentState!.validate()) {
      _showError('Please fix the errors above');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final username = _signupUsernameController.text.trim();
      final email = _signupEmailController.text.trim();
      final password = _signupPasswordController.text;
      final fullName = _fullNameController.text.trim();
      
      // Try API registration first
      final result = await ApiService.register(
        fullName,
        email,
        password,
      );
      
      if (result['success']) {
        if (!mounted) return;
        
        // Show success and switch to login
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Account created successfully! Please sign in.'),
            backgroundColor: darkGreen,
            behavior: SnackBarBehavior.floating,
          ),
        );
        
        // Clear signup form and switch to login
        _clearSignupForm();
        setState(() => _isSignUpMode = false);
        _loginUsernameController.text = email;
        return;
      }
      
      // Fallback to local registration
      // Check if username already exists
      final users = await _getStoredUsers();
      if (users != null && users.containsKey(username)) {
        throw Exception('Username already exists');
      }
      
      // Check if admin username is being used
      if (username.toLowerCase() == 'admin') {
        throw Exception('Username "admin" is reserved');
      }
      
      // Check if email already exists
      if (users != null) {
        for (var userData in users.values) {
          if ((userData as Map<String, dynamic>)['email'] == email) {
            throw Exception('Email already registered');
          }
        }
      }
      
      // Save new user locally
      final userData = {
        'email': email,
        'password': password,
        'fullName': fullName,
        'createdAt': DateTime.now().toIso8601String(),
      };
      
      await _saveUser(username, userData);
      
      if (!mounted) return;
      
      // Show success and switch to login
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Account created successfully! Please sign in.'),
          backgroundColor: darkGreen,
          behavior: SnackBarBehavior.floating,
        ),
      );
      
      // Clear signup form and switch to login
      _clearSignupForm();
      setState(() => _isSignUpMode = false);
      _loginUsernameController.text = username;
      
    } catch (e) {
      _showError(_getErrorMessage(e));
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleSuccessfulLogin(String username, {bool isAdmin = false, Map<String, dynamic>? userData}) async {
    // Save credentials if remember me is checked
    if (_rememberMe) {
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('remembered_username', username);
        await prefs.setBool('remember_me', true);
      } catch (e) {
        debugPrint('Error saving remember me: $e');
      }
    }
    
    // Save current session
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('current_user', username);
      await prefs.setBool('is_admin', isAdmin);
      if (userData != null) {
        await prefs.setString('current_user_data', json.encode(userData));
      }
    } catch (e) {
      debugPrint('Error saving session: $e');
    }
    
    if (!mounted) return;
    
    // Show success message
    final displayName = isAdmin ? 'Admin' : (userData?['fullName'] ?? username);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Welcome back, $displayName!'),
        backgroundColor: darkGreen,
        behavior: SnackBarBehavior.floating,
      ),
    );
    
    // Navigate to plan creation
    Navigator.pushReplacementNamed(context, '/create_plan');
  }

  String _getErrorMessage(dynamic error) {
    final errorMsg = error.toString();
    if (errorMsg.contains('Invalid credentials')) {
      return 'Invalid username or password';
    } else if (errorMsg.contains('Username already exists')) {
      return 'Username already exists. Please choose another.';
    } else if (errorMsg.contains('Email already registered')) {
      return 'Email already registered. Please use another email.';
    } else if (errorMsg.contains('Username "admin" is reserved')) {
      return 'Username "admin" is reserved. Please choose another.';
    } else if (errorMsg.contains('network')) {
      return 'Network error. Please check your connection';
    } else {
      return _isSignUpMode ? 'Sign up failed. Please try again.' : 'Login failed. Please try again';
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _clearSignupForm() {
    _signupUsernameController.clear();
    _signupEmailController.clear();
    _signupPasswordController.clear();
    _confirmPasswordController.clear();
    _fullNameController.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: darkGreen,
        elevation: 0,
        centerTitle: true,
        title: Text(
          _isSignUpMode ? 'Create Account' : 'Welcome Back',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  
                  // App logo/title
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [darkGreen, darkGreen.withOpacity(0.7)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: darkGreen.withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.restaurant,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text('FitMeal',
                            style: GoogleFonts.pacifico(
                              fontSize: 36, 
                              color: darkGreen,
                            )),
                        const SizedBox(height: 8),
                        Text(
                          _isSignUpMode 
                            ? 'Join the FitMeal community' 
                            : 'Your Personal Nutrition Guide',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          )),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 40),

                  // Mode toggle
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _isSignUpMode = false),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: !_isSignUpMode ? darkGreen : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Sign In',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: !_isSignUpMode ? Colors.white : Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _isSignUpMode = true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: _isSignUpMode ? darkGreen : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Sign Up',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: _isSignUpMode ? Colors.white : Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Forms
                  _isSignUpMode ? _buildSignUpForm() : _buildLoginForm(),

                  const SizedBox(height: 20),

                  // Skip option
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/create_plan');
                      },
                      child: Text(
                        'Continue as Guest',
                        style: GoogleFonts.poppins(
                          color: Colors.grey.shade600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _loginFormKey,
      child: Column(
        children: [
          // Username field
          _buildTextField(
            controller: _loginUsernameController,
            focusNode: _usernameFocusNode,
            validator: (v) => _validateUsername(v),
            labelText: 'Username',
            hintText: 'Enter your username',
            prefixIcon: Icons.person,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => _passwordFocusNode.requestFocus(),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]')),
              LengthLimitingTextInputFormatter(20),
            ],
          ),
          
          const SizedBox(height: 16),

          // Password field
          _buildTextField(
            controller: _loginPasswordController,
            focusNode: _passwordFocusNode,
            validator: (v) => _validatePassword(v),
            labelText: 'Password',
            hintText: 'Enter your password',
            prefixIcon: Icons.lock,
            isPassword: true,
            isPasswordVisible: _isPasswordVisible,
            onTogglePassword: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _handleLogin(),
          ),
          
          const SizedBox(height: 12),

          // Remember me and forgot password
          Row(
            children: [
              Checkbox(
                value: _rememberMe,
                onChanged: (value) => setState(() => _rememberMe = value ?? false),
                activeColor: darkGreen,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _rememberMe = !_rememberMe),
                  child: Text(
                    'Remember me',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: _showForgotPasswordDialog,
                child: Text(
                  'Forgot Password?',
                  style: GoogleFonts.poppins(
                    color: darkGreen,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Login button
          SizedBox(
            height: 56,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: darkGreen,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
              ),
              onPressed: _isLoading ? null : _handleLogin,
              child: _isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Signing in...',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      'Sign In',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSignUpForm() {
    return Form(
      key: _signupFormKey,
      child: Column(
        children: [
          // Full Name field
          _buildTextField(
            controller: _fullNameController,
            validator: _validateFullName,
            labelText: 'Full Name',
            hintText: 'Enter your full name',
            prefixIcon: Icons.person_outline,
            textInputAction: TextInputAction.next,
          ),
          
          const SizedBox(height: 16),

          // Username field
          _buildTextField(
            controller: _signupUsernameController,
            validator: (v) => _validateUsername(v, isSignup: true),
            labelText: 'Username',
            hintText: 'Choose a username',
            prefixIcon: Icons.alternate_email,
            textInputAction: TextInputAction.next,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]')),
              LengthLimitingTextInputFormatter(20),
            ],
          ),
          
          const SizedBox(height: 16),

          // Email field
          _buildTextField(
            controller: _signupEmailController,
            validator: _validateEmail,
            labelText: 'Email',
            hintText: 'Enter your email address',
            prefixIcon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          
          const SizedBox(height: 16),

          // Password field
          _buildTextField(
            controller: _signupPasswordController,
            validator: (v) => _validatePassword(v, isSignup: true),
            labelText: 'Password',
            hintText: 'Create a strong password',
            prefixIcon: Icons.lock,
            isPassword: true,
            isPasswordVisible: _isPasswordVisible,
            onTogglePassword: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
            textInputAction: TextInputAction.next,
          ),
          
          const SizedBox(height: 16),

          // Confirm Password field
          _buildTextField(
            controller: _confirmPasswordController,
            validator: _validateConfirmPassword,
            labelText: 'Confirm Password',
            hintText: 'Confirm your password',
            prefixIcon: Icons.lock_outline,
            isPassword: true,
            isPasswordVisible: _isConfirmPasswordVisible,
            onTogglePassword: () => setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _handleSignUp(),
          ),

          const SizedBox(height: 24),

          // Password requirements
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Password requirements:',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'â€¢ At least 8 characters\nâ€¢ Include uppercase and lowercase letters\nâ€¢ Include at least one number',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Sign up button
          SizedBox(
            height: 56,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: darkGreen,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
              ),
              onPressed: _isLoading ? null : _handleSignUp,
              child: _isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Creating account...',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      'Create Account',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String? Function(String?) validator,
    required String labelText,
    required String hintText,
    required IconData prefixIcon,
    FocusNode? focusNode,
    TextInputAction? textInputAction,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    bool isPassword = false,
    bool isPasswordVisible = false,
    VoidCallback? onTogglePassword,
    void Function(String)? onFieldSubmitted,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      obscureText: isPassword && !isPasswordVisible,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(prefixIcon, color: darkGreen),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: onTogglePassword,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: darkGreen, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      style: GoogleFonts.poppins(),
    );
  }

  void _showForgotPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Forgot Password?',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        content: Text(
          'Password reset is not implemented in demo mode.',
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: GoogleFonts.poppins(
                color: darkGreen,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}