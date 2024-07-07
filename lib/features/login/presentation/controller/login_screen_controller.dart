import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda_task/features/common/controller/shared_pref_utils.dart';
import 'package:tezda_task/features/common/widgets/common_snackbar.dart';
import 'package:tezda_task/features/login/data/repo/login_repository.dart';
import 'package:tezda_task/features/product_list/presentation/views/product_list_screen.dart';
import 'package:tezda_task/utils/color_utils.dart';

class LoginController extends StateNotifier<bool> {
  final LoginRepository _loginRepository;

  LoginController(this._loginRepository) : super(false);

  login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      state = true;
      await _loginRepository
          .loginUser(email: email, password: password)
          .then((value) {
        var emailRestored = SharedPrefUtil.getValue('email', "") as String;
        var passwordRestored =
            SharedPrefUtil.getValue('password', "") as String;
        if (emailRestored == email && passwordRestored == password) {
          SharedPrefUtil.setValue('isLoggedIn', true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ProductListScreen()),
          );
          state = false;
        } else {
          state = false;
          CommonSnackBar(
                  bgColor: AppColors.errorRedColor, message: 'Failed to login')
              .showSnackBar(context);
        }
      });
      state = false;
    } catch (error) {
      state = false;
    }
  }
}

final loginDataProvider = StateNotifierProvider<LoginController, bool>((ref) {
  return LoginController(ref.watch(loginProvider));
});
