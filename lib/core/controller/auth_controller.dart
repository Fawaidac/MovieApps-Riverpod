import 'package:fininite_riverpod/core/model/user_model.dart';
import 'package:fininite_riverpod/core/provider/db_provider.dart';
import 'package:fininite_riverpod/core/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  final Ref ref;
  final AuthRepository authRepository;

  AuthController({required this.ref, required this.authRepository}) {
    initializeUser();
  }

  Future<void> updateUserData(String name, String email) async {
    final prefs = await SharedPreferences.getInstance();

    // Clear old data
    await prefs.clear();

    // Save new data
    await prefs.setString('username', name);
    await prefs.setString('email', email);

    // Update the state
    ref.read(authStateProvider.notifier).state =
        User(username: name, email: email);
  }

  Future<void> initializeUser() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      // Assuming we have a method to get user data by email
      final email = prefs.getString('userEmail');
      if (email != null) {
        final user = await authRepository.getUserByEmail(email);
        if (user != null) {
          ref.read(authStateProvider.notifier).state = user;
        }
      }
    }
  }

  Future<bool> login(String email, String password) async {
    final user = await authRepository.login(email, password);
    if (user != null) {
      ref.read(authStateProvider.notifier).state = user;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userEmail', email);
      return true;
    }
    return false;
  }

  Future<bool> register(String username, String email, String password) async {
    try {
      await authRepository.register(username, email, password);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    ref.read(authStateProvider.notifier).state = null;
  }

  User? getDataUser() {
    return ref.read(authStateProvider);
  }
}
