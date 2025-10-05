// lib/features/auth/providers/auth_provider.dart
import 'package:flutter/foundation.dart';
import 'package:dwarka_app/features/auth/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService;
  bool _isLoading = false;
  String? _errorMessage;

  AuthProvider(this._authService);

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> signInWithEmail(String email, String password) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      await _authService.signInWithEmail(email, password);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signUpWithEmail(String email, String password) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      await _authService.signUpWithEmail(email, password);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signInWithGoogle() async {
    _setLoading(true);
    _errorMessage = null;
    try {
      await _authService.signInWithGoogle();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}