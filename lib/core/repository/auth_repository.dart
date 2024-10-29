import 'package:fininite_riverpod/core/helper/db.dart';
import 'package:fininite_riverpod/core/model/user_model.dart';

class AuthRepository {
  final DatabaseHelper databaseHelper;

  AuthRepository({required this.databaseHelper});

  Future<User?> login(String email, String password) async {
    return await databaseHelper.getUser(email, password);
  }

  Future<void> register(String username, String email, String password) async {
    final user = User(username: username, email: email, password: password);
    await databaseHelper.insertUser(user);
  }
}
