import 'package:fininite_riverpod/core/provider/db_provider.dart';
import 'package:fininite_riverpod/core/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthController {
  final Ref ref;
  final AuthRepository authRepository;

  AuthController({required this.ref, required this.authRepository});

  Future<bool> login(String email, String password) async {
    final user = await authRepository.login(email, password);
    if (user != null) {
      ref.read(authStateProvider.notifier).state = user;
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
}
