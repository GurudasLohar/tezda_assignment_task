import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda_task/features/login/presentation/views/login_screen.dart';
import 'package:tezda_task/features/product_list/presentation/views/product_list_screen.dart';
import 'features/common/controller/shared_pref_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefUtil.init();
  runApp(const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tezda Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SharedPrefUtil.getValue("isLoggedIn", false) as bool
          ? const ProductListScreen()
          : const LoginScreen(),
    );
  }
}
