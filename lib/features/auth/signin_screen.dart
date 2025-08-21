import 'package:dwarka_app/features/auth/signup_screen.dart';
import 'package:dwarka_app/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // ✅ Gradient Background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF90CAF9), Color(0xFFE3F2FD)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              double width = constraints.maxWidth;

              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: ConstrainedBox(
                    // ✅ Keeps UI centered on PC screens
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),

                        // ==== Title ====
                        Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width > 600 ? 38 : 32,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // ==== Email Field ====
                        _buildTextField('Email Address'),
                        const SizedBox(height: 16),

                        // ==== Password Field ====
                        _buildTextField('Password', isPassword: true),
                        const SizedBox(height: 24),

                        // ==== Sign In Button ====
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: primaryColor.withValues(alpha: 0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: width > 600 ? 20 : 18,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/home');
                            },
                          ),
                        ),
                        const SizedBox(height: 24),

                        // ==== Don't have account? ====
                        Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: width > 600 ? 18 : 16,
                                fontWeight: FontWeight.w500,
                              ),
                              children: [
                                const TextSpan(text: "Don't have an Account? "),
                                TextSpan(
                                  text: 'Create one',
                                  style: TextStyle(
                                    fontSize: width > 600 ? 18 : 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                          const SignupScreen(),
                                        ),
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),

                        // ==== Social Buttons ====
                        Column(
                          children: [
                            _buildSocialButton(
                              context,
                              FontAwesomeIcons.apple,
                              Colors.black,
                              'Continue with Apple',
                            ),
                            const SizedBox(height: 16),
                            _buildSocialButton(
                              context,
                              FontAwesomeIcons.google,
                              const Color(0xFFDB4437),
                              'Continue with Google',
                            ),
                            const SizedBox(height: 16),
                            _buildSocialButton(
                              context,
                              FontAwesomeIcons.facebook,
                              const Color(0xFF4267B2),
                              'Continue with Facebook',
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
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

  // ==== Reusable Styled TextField ====
  Widget _buildTextField(String placeholder, {bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: CupertinoTextField(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        placeholder: placeholder,
        obscureText: isPassword,
        placeholderStyle: TextStyle(
          color: Colors.black.withValues(alpha: 0.3),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }

  // ==== Reusable Styled Social Button ====
  Widget _buildSocialButton(
      BuildContext context, IconData icon, Color color, String text) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: SocialLoginButton(
        icon: icon,
        color: color,
        text: text,
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/home');
        },
      ),
    );
  }
}

// ==== Social Button Component ====
class SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback onPressed;
  const SocialLoginButton({
    super.key,
    required this.icon,
    required this.color,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, // ✅ Left aligned
          children: [
            Icon(
              icon,
              color: color,
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
