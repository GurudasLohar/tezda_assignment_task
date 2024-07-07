import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda_task/features/common/controller/shared_pref_utils.dart';
import 'package:tezda_task/features/login/presentation/views/login_screen.dart';
import 'package:tezda_task/features/register/data/repo/register_repository.dart';

class RegisterController extends StateNotifier<bool> {
  final RegisterRepository _registerRepository;

  RegisterController(this._registerRepository) : super(false);

  register(
      {required String name,
      required String email,
      required String password,
      required BuildContext context,}) async {
    try {
      state = true;
      await _registerRepository
          .registerUser(name: name, email: email, password: password)
          .then((value) {
        SharedPrefUtil.setValue("name", name);
        SharedPrefUtil.setValue("email", email);
        SharedPrefUtil.setValue("password", password);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      });
      state = false;
    } catch (error) {
      state = false;
    }
  }
}

final registerDataProvider =
    StateNotifierProvider<RegisterController, bool>((ref) {
  return RegisterController(ref.watch(registerProvider));
});
