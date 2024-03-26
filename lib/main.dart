import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:manager_system/a.dart';
import 'package:manager_system/b.dart';
import 'package:manager_system/db/dbHelper.dart';
import 'package:manager_system/feature/tab1/stock.dart';
import 'package:manager_system/feature/tab2/productIn.dart';
import 'package:manager_system/typeSet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final db = DBHelper();
  @override
  void initState() {
    super.initState();
    db.createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen();
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static final List<Widget> _screens = [
    ProductList(),
    ProductInWidget(),
    Center(child: MyTable()),
    Center(child: MyHomePage22()),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('...'),
      ),
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            label: '库存',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_downward),
            label: '进货',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_upward),
            label: '出货',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: '数据统计',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        // unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
