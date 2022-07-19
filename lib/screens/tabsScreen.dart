import 'package:flutter/material.dart';
import 'package:mygametips/screens/homeScreen.dart';
import '../components/main_drawer.dart';
import '../utils/app_routes.dart';
import './jogo/jogosScreen.dart';
import '../models/jogo_state.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _indexSelectedScreen = 0;

  final List<Widget> _screens = [HomeScreen(), JogosScreen()];

  _selectScreen(int index) {
    setState(() {
      _indexSelectedScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, snp) {
      return Scaffold(
        appBar: AppBar(title: Text('My Game Tips')),
        body: _screens[_indexSelectedScreen],
        drawer: MainDrawer(),
      );
    });
  }
}
