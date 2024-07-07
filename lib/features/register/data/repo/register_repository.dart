import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterRepository {
  bool isRegister = false;

  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 3), () {
      isRegister = true;
    });
    return isRegister;
  }
}

final registerProvider =
    Provider<RegisterRepository>((ref) => RegisterRepository());
