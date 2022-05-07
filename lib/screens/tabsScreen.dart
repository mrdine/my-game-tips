import 'package:flutter/material.dart';
import './jogo/jogosScreen.dart';
import '../models/jogo.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _indexSelectedScreen = 0;

  final List<Widget> _screens = [
    JogosScreen(
      myGames: [],
    )
  ];

  _selectScreen(int index) {
    setState(() {
      _indexSelectedScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Game Tips')),
      body: _screens[_indexSelectedScreen],
      drawer: Drawer(
        child: Container(
          height: 120,
          padding: EdgeInsets.all(40),
          child: Text('Menu Principal'),
        ),
      ),
    );
  }
}
