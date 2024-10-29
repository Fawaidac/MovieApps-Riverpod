import 'package:fininite_riverpod/core/helper/db.dart';
import 'package:fininite_riverpod/core/model/user_model.dart';
import 'package:fininite_riverpod/core/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/auth_controller.dart';

final databaseProvider = Provider((ref) => DatabaseHelper.instance);

final authRepositoryProvider = Provider((ref) {
  final dbHelper = ref.watch(databaseProvider);
  return AuthRepository(databaseHelper: dbHelper);
});

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(ref: ref, authRepository: authRepository);
});

final authStateProvider = StateProvider<User?>((ref) => null);
