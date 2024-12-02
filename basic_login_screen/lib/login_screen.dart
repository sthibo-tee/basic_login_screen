import 'package:flutter/material.dart';
import 'database.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {

  List<Map<String, dynamic>> users = [];
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    await DatabaseHelper.initDatabase();
    await _fetchData();
  }

  Future<void> _fetchData() async {
    final data = await DatabaseHelper.database.query('users');
    setState(() {
      users = data;
    });
  }

  Future<bool> _validateUser(String userName, String passWord) async {
    for (var user in users) {
      if(user['username'] == userName && user['password'] == passWord) {
        return true;
      }
    }
    return false;
  }

  Future<void> _login() async {
    setState(() {
      isLoading = true;
    });

    bool isValid = await _validateUser(
      _usernameController.text,
      _passwordController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('login worked!'))
      );
      Navigator.popAndPushNamed(context, "/main");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('did not login'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Username",
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password",
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        _login();
                      },
                      child: const Text("Login"),
                    ),
              TextButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, "/signUp");
                },
                child: const Text("SignUp"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}