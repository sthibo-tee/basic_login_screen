import 'package:flutter/material.dart';
import 'database.dart';

class SignupScreen extends StatefulWidget{
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() {
    return _SignupScreenState();
  }
}

class _SignupScreenState extends State<SignupScreen> {

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
    try{
      final data = await DatabaseHelper.database.query('users');
      setState(() {
        users = data;
      });
    } catch (e) {
      print("errro handling $e");
    }
  }
  
  Future<void> _addUser(String userName, String passWord) async {
   try {
      setState(() {
        isLoading = true;
      });
      if (userName.isNotEmpty && passWord.isNotEmpty) {
        await DatabaseHelper.database.insert(
          'users',
          {'username': userName, 'password': passWord}
        );

        setState(() {
          isLoading = false;
        });
        _passwordController.clear();
        _usernameController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User added successfully')),
        );
        await _fetchData();
        Navigator.popAndPushNamed(context, "/login");
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please fill in all fields')),
          );
        });
      }
    } catch (e) {
      print('error handling $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign UP"),
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
                  label: Text("Username"),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Password"),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              isLoading
                ? const CircularProgressIndicator()
                :ElevatedButton(
                  onPressed: () {
                    _addUser(_usernameController.text.trim(), _passwordController.text.trim());
                  },
                  child: const Text('Sign Up'),
                ),
              TextButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, "/login");
                },
                child: const Text("login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}