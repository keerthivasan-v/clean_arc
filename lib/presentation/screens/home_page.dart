import 'package:clean_arc/cubit/UserDetails/Userdetails_cubit.dart';
import 'package:clean_arc/presentation/screens/ListUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    ListUser(),
 
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
        backgroundColor: Color.fromARGB(255, 38, 2, 129),
        title: const Text(
          'Job Seekers',
          style: TextStyle(color: Colors.white, fontFamily: 'SFPro-BItalic'),
        ),
        shadowColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
