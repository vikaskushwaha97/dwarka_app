// lib/features/auth/services/auth_service.dart

// Simple user model for authentication
class AppUser {
  final String uid;
  final String? email;
  final String? displayName;
  final String? phoneNumber;

  AppUser({
    required this.uid,
    this.email,
    this.displayName,
    this.phoneNumber,
  });
}

// Authentication service with mock implementations
class AuthService {
  bool _isInitialized = false;

  // Initialize service
  Future<void> initialize() async {
    if (!_isInitialized) {
      // Simulate initialization delay
      await Future.delayed(const Duration(milliseconds: 500));
      _isInitialized = true;
    }
  }

  // Sign in with email and password
  Future<AppUser?> signInWithEmail(String email, String password) async {
    await initialize();

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Validation
    if (email.isEmpty || password.isEmpty) {
      throw 'Please enter both email and password';
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      throw 'Please enter a valid email address';
    }

    if (password.length < 6) {
      throw 'Password must be at least 6 characters';
    }

    // Mock successful login
    return AppUser(
      uid: 'email_uid_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      displayName: email.split('@')[0],
    );
  }

  // Sign up with email and password
  Future<AppUser?> signUpWithEmail(String email, String password) async {
    await initialize();

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Validation
    if (email.isEmpty || password.isEmpty) {
      throw 'Please enter both email and password';
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      throw 'Please enter a valid email address';
    }

    if (password.length < 6) {
      throw 'Password must be at least 6 characters';
    }

    // Mock successful registration
    return AppUser(
      uid: 'email_uid_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      displayName: email.split('@')[0],
    );
  }

  // Sign in with phone number
  Future<String> signInWithPhone(String phoneNumber) async {
    await initialize();

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Validation
    if (phoneNumber.isEmpty) {
      throw 'Please enter your phone number';
    }

    // Basic phone validation (simple version)
    final cleanedPhone = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanedPhone.length < 10) {
      throw 'Please enter a valid phone number';
    }

    // Return mock verification ID (in real app, this would come from Firebase)
    return 'mock_verification_id_${DateTime.now().millisecondsSinceEpoch}';
  }

  // Verify OTP
  Future<AppUser?> verifyOtp(String verificationId, String otp) async {
    await initialize();

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Validation
    if (otp.isEmpty || otp.length != 6) {
      throw 'Please enter a valid 6-digit OTP';
    }

    // Mock OTP validation - accept any 6-digit code that's not all zeros
    if (otp == '000000') {
      throw 'Invalid OTP code. Please try again.';
    }

    // Mock successful verification
    return AppUser(
      uid: 'phone_uid_${DateTime.now().millisecondsSinceEpoch}',
      phoneNumber: '+1234567890', // Mock phone number
    );
  }

  // Sign in with Google (mock implementation)
  Future<AppUser?> signInWithGoogle() async {
    await initialize();

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    try {
      // Mock Google sign-in success
      return AppUser(
        uid: 'google_uid_${DateTime.now().millisecondsSinceEpoch}',
        email: 'mockuser@gmail.com',
        displayName: 'Google User',
      );
    } catch (e) {
      throw 'Google sign-in failed. Please try again.';
    }
  }

  // Sign in with Apple (mock implementation)
  Future<AppUser?> signInWithApple() async {
    await initialize();

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    try {
      // Mock Apple sign-in success
      return AppUser(
        uid: 'apple_uid_${DateTime.now().millisecondsSinceEpoch}',
        email: 'mockuser@apple.com',
        displayName: 'Apple User',
      );
    } catch (e) {
      throw 'Apple sign-in failed. Please try again.';
    }
  }

  // Sign in with Facebook (mock implementation)
  Future<AppUser?> signInWithFacebook() async {
    await initialize();

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    try {
      // Mock Facebook sign-in success
      return AppUser(
        uid: 'facebook_uid_${DateTime.now().millisecondsSinceEpoch}',
        email: 'mockuser@facebook.com',
        displayName: 'Facebook User',
      );
    } catch (e) {
      throw 'Facebook sign-in failed. Please try again.';
    }
  }

  // Sign out
  Future<void> signOut() async {
    await initialize();

    // Simulate sign out delay
    await Future.delayed(const Duration(milliseconds: 500));
  }

  // Get current user (mock implementation)
  Future<AppUser?> getCurrentUser() async {
    await initialize();

    // Return null to simulate no logged-in user
    // In a real app, this would check Firebase Auth current user
    return null;
  }

  // Password reset (mock implementation)
  Future<void> resetPassword(String email) async {
    await initialize();

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Validation
    if (email.isEmpty) {
      throw 'Please enter your email address';
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      throw 'Please enter a valid email address';
    }

    // Mock successful password reset request
    // In a real app, this would send a password reset email
  }
}