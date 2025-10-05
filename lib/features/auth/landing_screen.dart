import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dwarka_app/utils/constant.dart';
import 'package:go_router/go_router.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set background gradient for the entire screen
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
            stops: [0.1, 0.6, 1.0], // Color distribution percentages
          ),
        ),
        child: SafeArea(
          // Add padding around all content
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /*
                * APP LOGO SECTION
                * Circular container with the app logo/image
                * Has a subtle border and background for visual appeal
                */
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1), // Semi-transparent white
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      'assets/images/dwarka_logo.jpg',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.photo, color: Colors.white, size: 60),
                    ),
                  ),
                ),
                const SizedBox(height: 40), // Spacer between logo and title

                /*
                * WELCOME TITLE SECTION
                * Main heading text for the landing page
                */
                Text(
                  'Welcome to Dwarka',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center, // Center align for better appearance
                ),
                const SizedBox(height: 8), // Small spacer

                /*
                * SUBTITLE SECTION
                * Descriptive text explaining the app's purpose
                */
                Text(
                  'Premium eyewear for everyone',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60), // Large spacer before buttons

                /*
                * SIGN IN BUTTON
                * Primary action button for existing users
                * Uses elevated button style for prominence
                */
                SizedBox(
                  width: double.infinity, // Full width button
                  height: 54, // Standard button height
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to sign in screen using GoRouter
                      context.go('/signin');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // White background
                      foregroundColor: primaryColor, // Text color from constants
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // Rounded corners
                      ),
                      elevation: 4, // Subtle shadow for depth
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16), // Spacer between buttons

                /*
                * SIGN UP BUTTON
                * Secondary action button for new users
                * Uses outlined style to differentiate from primary button
                */
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: OutlinedButton(
                    onPressed: () {
                      // Navigate to sign up screen
                      context.go('/signup');
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.transparent, // Transparent background
                      foregroundColor: Colors.white, // White text
                      side: const BorderSide(color: Colors.white, width: 2), // White border
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40), // Spacer before social login section

                /*
                * SOCIAL LOGIN SECTION
                * Alternative login options using social media accounts
                */
                Text(
                  'Or continue with',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20), // Spacer

                // Social media login options
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google login button
                    IconButton(
                      onPressed: () {
                        // Direct navigation for demo purposes
                        // In production, implement actual Google auth
                        context.go('/home');
                      },
                      icon: const Icon(
                        FontAwesomeIcons.google,
                        color: Colors.white,
                        size: 28,
                      ),
                      iconSize: 28, // Explicit size for consistency
                    ),
                    const SizedBox(width: 20), // Spacer between icons

                    // Facebook login button
                    IconButton(
                      onPressed: () {
                        // Direct navigation for demo purposes
                        // In production, implement actual Facebook auth
                        context.go('/home');
                      },
                      icon: const Icon(
                        FontAwesomeIcons.facebook,
                        color: Colors.white,
                        size: 28,
                      ),
                      iconSize: 28, // Explicit size for consistency
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}