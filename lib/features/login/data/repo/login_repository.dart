import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginRepository {
  bool isLogin = false;

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2), () {
      isLogin = true;
    });
    return isLogin;
  }
}

final loginProvider =
Provider<LoginRepository>((ref) => LoginRepository());
