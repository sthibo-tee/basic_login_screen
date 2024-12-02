import 'package:flutter/material.dart';
// import 'database.dart';

class MainScreen extends StatefulWidget{
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {

  // List<Map<String, dynamic>> users = [];


  // @override
  // void initState() {
  //   super.initState();
  //   _initDatabase();
  // }

  // Future<void> _initDatabase() async {
  //   await DatabaseHelper.initDatabase();
  //   await _fetchData();
  // }

  // Future<void> _fetchData() async {
  //   final data = await DatabaseHelper.database.query('users');
  //   setState(() {
  //     users = data;
  //   });
  // }

  // Future<void> _add(String userName, String passWord) async {
  //   await DatabaseHelper.database.insert(
  //     'users',
  //     {'username': userName, 'password': passWord},
  //   );
  //   _fetchData();
  // }

  // Future<void> _updatedata(String userName, String passWord) async {
  //   await DatabaseHelper.database.update(
  //     'users',
  //     {'username': userName, 'password': passWord},
  //     where: 'username = ?',
  //     whereArgs: [userName],
  //   );
  //   _fetchData();
  // }

  // Future<void> _deleteData(String userName) async {
  //   await DatabaseHelper.database.delete(
  //     'users',
  //     where: 'username = ?',
  //     whereArgs: [userName],
  //   );
  //   _fetchData();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
      ),
      body: const Center(
        child: Text('main screen'),
      ),
    );
  }
}