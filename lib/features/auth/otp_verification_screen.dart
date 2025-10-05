import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:dwarka_app/utils/constant.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OTPVerificationScreen({super.key, required this.phoneNumber});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  // Controllers and focus nodes for each of the 6 OTP digits
  final List<TextEditingController> _otpControllers =
  List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  bool _isLoading = false; // Loading state for verification process
  int _resendTimer = 60;   // Countdown timer for resend OTP functionality
  late Timer _timer;       // Timer object for the countdown

  @override
  void initState() {
    super.initState();
    _startResendTimer(); // Start the resend countdown timer

    // Auto-focus first OTP field after a short delay
    Future.delayed(const Duration(milliseconds: 300), () {
      FocusScope.of(context).requestFocus(_focusNodes[0]);
    });
  }

  /*
  * START RESEND TIMER METHOD
  * Initializes and starts a countdown timer for OTP resend functionality
  * Timer counts down from 60 seconds and updates UI every second
  */
  void _startResendTimer() {
    _resendTimer = 60; // Reset timer to 60 seconds
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimer == 0) {
        timer.cancel(); // Stop timer when it reaches 0
      } else {
        setState(() => _resendTimer--); // Decrement timer and update UI
      }
    });
  }

  /*
  * VERIFY OTP METHOD
  * Validates and processes the entered OTP
  * Simulates network request with a delay
  * Navigates to home screen on successful verification
  */
  void _verifyOTP() {
    // Combine all OTP digits into a single string
    final otp = _otpControllers.map((controller) => controller.text).join();

    // Only proceed if all 6 digits are entered
    if (otp.length == 6) {
      setState(() => _isLoading = true); // Show loading indicator

      // Simulate OTP verification process (replace with actual API call)
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        context.go('/home'); // Navigate to home screen using GoRouter
      });
    }
  }

  /*
  * RESEND OTP METHOD
  * Handles the OTP resend functionality
  * Only works when the resend timer has expired
  * Shows a success message when OTP is resent
  */
  void _resendOTP() {
    if (_resendTimer == 0) {
      _startResendTimer(); // Restart the countdown timer

      // Show success message using a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('OTP sent successfully'),
          backgroundColor: primaryColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }
  }

  /*
  * ON OTP CHANGED METHOD
  * Handles text input changes in OTP fields
  * Automatically moves focus to next/previous field based on input
  * Auto-submits form when all fields are filled
  */
  void _onOTPChanged(int index, String value) {
    // Move to next field if current field has a value
    if (value.isNotEmpty && index < 5) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    }

    // Move to previous field if current field is empty (backspace pressed)
    if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }

    // Auto-submit when all fields are filled (last field receives input)
    if (index == 5 && value.isNotEmpty) {
      final allFilled = _otpControllers.every((controller) => controller.text.isNotEmpty);
      if (allFilled) {
        _verifyOTP(); // Initiate OTP verification
      }
    }
  }

  @override
  void dispose() {
    // Clean up resources to prevent memory leaks
    _timer.cancel(); // Cancel the timer

    // Dispose all text editing controllers
    for (var controller in _otpControllers) {
      controller.dispose();
    }

    // Dispose all focus nodes
    for (var node in _focusNodes) {
      node.dispose();
    }

    super.dispose();
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
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*
                * BACK BUTTON
                * Allows user to navigate back to previous screen
                */
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),

                // Main content area
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /*
                          * OTP ICON
                          * Visual indicator for OTP verification process
                          */
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 2,
                              ),
                            ),
                            child: const Icon(
                              Iconsax.sms,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          const SizedBox(height: 30),

                          /*
                          * TITLE
                          * Screen title indicating the purpose
                          */
                          Text(
                            'Verify OTP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 10),

                          /*
                          * DESCRIPTION
                          * Instructions for the user with phone number display
                          */
                          Text(
                            'Enter the 6-digit code sent to\n${widget.phoneNumber}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 40),

                          /*
                          * OTP INPUT FIELDS
                          * Six individual text fields for OTP digits
                          * Auto-focus moves between fields as user types
                          */
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(6, (index) {
                              return SizedBox(
                                width: 45,
                                child: TextFormField(
                                  controller: _otpControllers[index],
                                  focusNode: _focusNodes[index],
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  maxLength: 1, // Limit to single character
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  decoration: InputDecoration(
                                    counterText: '', // Hide character counter
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.1),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Colors.white.withOpacity(0.3),
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  onChanged: (value) => _onOTPChanged(index, value),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 40),

                          /*
                          * VERIFY BUTTON
                          * Primary action button to verify the entered OTP
                          * Shows loading indicator during verification process
                          */
                          SizedBox(
                            width: double.infinity,
                            height: 54,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _verifyOTP,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 4,
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation(Colors.white),
                                ),
                              )
                                  : const Text(
                                'Verify OTP',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          /*
                          * RESEND OTP SECTION
                          * Allows user to request a new OTP after timer expires
                          * Shows countdown when timer is active
                          */
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Didn't receive the code? ",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 14,
                                ),
                              ),
                              GestureDetector(
                                onTap: _resendTimer == 0 ? _resendOTP : null,
                                child: Text(
                                  _resendTimer == 0
                                      ? 'Resend'
                                      : 'Resend in $_resendTimer',
                                  style: TextStyle(
                                    color: _resendTimer == 0
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.6),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}