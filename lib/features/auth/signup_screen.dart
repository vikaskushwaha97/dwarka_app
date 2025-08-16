import 'package:dwarka_app/features/auth/signin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/constant.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // ✅ Modern gradient background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white, // form card
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          'Create Account',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // ==== TextFields ====
                        _buildTextField('First Name'),
                        const SizedBox(height: 16),
                        _buildTextField('Last Name'),
                        const SizedBox(height: 16),
                        _buildTextField('Email Address'),
                        const SizedBox(height: 16),
                        _buildTextField('Password', isPassword: true),

                        const SizedBox(height: 30),

                        // ==== Sign Up Button ====
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
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),

                        const SizedBox(height: 28),

                        // ==== Already have account ====
                        Center(
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                color: TextFieldTextColorColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              children: [
                                const TextSpan(text: "Already have an Account? "),
                                TextSpan(
                                  text: 'Sign In',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                          const SigninScreen(),
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
                              FontAwesomeIcons.apple,
                              Colors.black,
                              'Continue with Apple',
                            ),
                            const SizedBox(height: 16),
                            _buildSocialButton(
                              FontAwesomeIcons.google,
                              const Color(0xFFDB4437),
                              'Continue with Google',
                            ),
                            const SizedBox(height: 16),
                            _buildSocialButton(
                              FontAwesomeIcons.facebook,
                              const Color(0xFF4267B2),
                              'Continue with Facebook',
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ==== Styled TextField ====
  Widget _buildTextField(String placeholder, {bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        color: textFieldColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.15),
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
          color: textFieldColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }

  // ==== Styled Social Button ====
  Widget _buildSocialButton(IconData icon, Color color, String text) {
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
        onPressed: () {},
      ),
    );
  }
}
