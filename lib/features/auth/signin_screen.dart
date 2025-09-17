
import 'package:dwarka_app/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  // Controllers for text input fields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _isPasswordVisible = false; // Toggle password visibility
  bool _isLoading = false;         // Loading state for sign-in process
  bool _usePhoneLogin = true;      // Toggle between phone and email login

  @override
  void dispose() {
    // Clean up controllers to prevent memory leaks
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  /*
  * SIGN IN METHOD
  * Handles the authentication process based on selected login method
  * For phone login: navigates to OTP verification screen
  * For email login: directly navigates to home screen (simulated)
  */
  void _signIn() async {
    // Validate required fields based on login method
    if (_usePhoneLogin && _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter your phone number'),
          backgroundColor: Colors.red[400],
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (!_usePhoneLogin && (_emailController.text.isEmpty || _passwordController.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill all fields'),
          backgroundColor: Colors.red[400],
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isLoading = true); // Show loading indicator

    // Simulate network request delay
    await Future.delayed(const Duration(seconds: 1));

    if (_usePhoneLogin) {
      // Navigate to OTP verification screen for phone login
      context.go(
        '/otp-verification',
        extra: {'phoneNumber': _phoneController.text},
      );
    } else {
      // For email login, directly navigate to home (simulated authentication)
      context.go('/home');
    }

    setState(() => _isLoading = false); // Hide loading indicator
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF5085E1), // Light blue
              Color(0xFF0054D4), // Medium blue
              Color(0xFF003A9B), // Dark blue
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.6, 1.0], // Color distribution
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final isLargeScreen = width > 600; // Responsive breakpoint

              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /*
                        * BACK BUTTON
                        * Allows navigation back to previous screen
                        */
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),

                        // ==== LOGO & WELCOME SECTION ====
                        _buildWelcomeSection(isLargeScreen),
                        const SizedBox(height: 40),

                        // ==== LOGIN CARD ====
                        Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                // Login Method Toggle (Phone/Email)
                                _buildLoginMethodToggle(),
                                const SizedBox(height: 20),

                                // ==== PHONE/EMAIL FIELD ====
                                _usePhoneLogin ? _buildPhoneField() : _buildEmailField(),
                                const SizedBox(height: 20),

                                // ==== PASSWORD FIELD (only for email login) ====
                                if (!_usePhoneLogin) _buildPasswordField(),
                                if (!_usePhoneLogin) const SizedBox(height: 16),

                                // ==== FORGOT PASSWORD (only for email login) ====
                                if (!_usePhoneLogin)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {
                                        // TODO: Implement forgot password functionality
                                      },
                                      child: Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: isLargeScreen ? 16 : 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                if (!_usePhoneLogin) const SizedBox(height: 24),

                                // ==== SIGN IN BUTTON ====
                                _buildSignInButton(isLargeScreen),
                                const SizedBox(height: 32),

                                // ==== DIVIDER ====
                                _buildDivider(),
                                const SizedBox(height: 32),

                                // ==== SOCIAL LOGIN BUTTONS ====
                                _buildSocialButtons(),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // ==== SIGN UP PROMPT ====
                        _buildSignUpPrompt(isLargeScreen),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /*
  * WELCOME SECTION WIDGET
  * Displays app logo and welcome message
  */
  Widget _buildWelcomeSection(bool isLargeScreen) {
    return Column(
      children: [
        // App Logo
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.2), width: 2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              'assets/images/dwarka_logo.jpg',
              width: isLargeScreen ? 80 : 60,
              height: isLargeScreen ? 80 : 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.photo, color: Colors.white, size: isLargeScreen ? 60 : 40),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Welcome Title
        Text(
          'Welcome Back',
          style: TextStyle(
            color: Colors.white,
            fontSize: isLargeScreen ? 32 : 28,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),

        // Welcome Subtitle
        Text(
          'Sign in to continue your eyewear journey',
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: isLargeScreen ? 18 : 16,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /*
  * LOGIN METHOD TOGGLE WIDGET
  * Allows user to switch between phone and email login methods
  */
  Widget _buildLoginMethodToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Phone Login Option
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _usePhoneLogin = true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: _usePhoneLogin ? primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Phone',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _usePhoneLogin ? Colors.white : Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),

          // Email Login Option
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _usePhoneLogin = false),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: !_usePhoneLogin ? primaryColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Email',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: !_usePhoneLogin ? Colors.white : Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /*
  * PHONE INPUT FIELD WIDGET
  * Text field for phone number input with validation
  */
  Widget _buildPhoneField() {
    return TextFormField(
      controller: _phoneController,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        labelStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Icon(Iconsax.call, color: Colors.grey[600]),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
      ),
      keyboardType: TextInputType.phone,
      style: const TextStyle(fontSize: 16),
    );
  }

  /*
  * EMAIL INPUT FIELD WIDGET
  * Text field for email address input with validation
  */
  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email Address',
        labelStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Icon(Iconsax.sms, color: Colors.grey[600]),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(fontSize: 16),
    );
  }

  /*
  * PASSWORD INPUT FIELD WIDGET
  * Text field for password input with visibility toggle
  */
  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Icon(Iconsax.lock, color: Colors.grey[600]),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Iconsax.eye : Iconsax.eye_slash,
            color: Colors.grey[600],
          ),
          onPressed: () {
            setState(() => _isPasswordVisible = !_isPasswordVisible);
          },
        ),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
      ),
      style: const TextStyle(fontSize: 16),
    );
  }

  /*
  * SIGN IN BUTTON WIDGET
  * Primary action button for authentication
  * Shows loading indicator during process
  */
  Widget _buildSignInButton(bool isLargeScreen) {
    return SizedBox(
      width: double.infinity,
      height: isLargeScreen ? 60 : 54,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _signIn,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          shadowColor: primaryColor.withOpacity(0.4),
        ),
        child: _isLoading
            ? SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
        )
            : Text(
          'Sign In',
          style: TextStyle(
            fontSize: isLargeScreen ? 18 : 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  /*
  * DIVIDER WIDGET
  * Visual separator with "or" text for social login options
  */
  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey[300],
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'or continue with',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey[300],
            thickness: 1,
          ),
        ),
      ],
    );
  }

  /*
  * SOCIAL LOGIN BUTTONS WIDGET
  * Provides alternative login options using social media accounts
  */
  Widget _buildSocialButtons() {
    return Column(
      children: [
        _buildSocialButton(
          icon: FontAwesomeIcons.google,
          color: const Color(0xFFDB4437),
          text: 'Continue with Google',
        ),
        const SizedBox(height: 12),
        _buildSocialButton(
          icon: FontAwesomeIcons.facebook,
          color: const Color(0xFF4267B2),
          text: 'Continue with Facebook',
        ),
        const SizedBox(height: 12),
        _buildSocialButton(
          icon: FontAwesomeIcons.apple,
          color: Colors.black,
          text: 'Continue with Apple',
        ),
      ],
    );
  }

  /*
  * INDIVIDUAL SOCIAL BUTTON WIDGET
  * Reusable component for social login buttons
  */
  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
    required String text,
  }) {
    return OutlinedButton(
      onPressed: () {
        // TODO: Implement social authentication
        context.go('/home');
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        side: BorderSide(color: Colors.grey[300]!),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        elevation: 1,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /*
  * SIGN UP PROMPT WIDGET
  * Encourages new users to create an account
  */
  Widget _buildSignUpPrompt(bool isLargeScreen) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            color: Colors.white,
            fontSize: isLargeScreen ? 16 : 14,
          ),
          children: [
            const TextSpan(text: "Don't have an account? "),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: isLargeScreen ? 16 : 14,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // Navigate to sign up screen
                  context.go('/signup');
                },
            ),
          ],
        ),
      ),
    );
  }
}