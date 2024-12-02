import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'main_screen.dart';
// import 'item_list_screen.dart';
import 'database.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  await DatabaseHelper.initDatabase();
  runApp(const MainApp());
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/login",
      routes: {
        "/login" : (context) => const LoginScreen(),
        "/signUp" : (context) => const SignupScreen(),
        "/main" : (context) => const MainScreen(),
      },
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 25, 126, 16)),
      ),
    );
  }
}