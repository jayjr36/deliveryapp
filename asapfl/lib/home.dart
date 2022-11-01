import './activeorder.dart';
import './history.dart';
import './info.dart';
import 'package:flutter/material.dart';
import './homepg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static List<Widget> pages = <Widget>[
    const Homepg(),
    const ActiveOrder(),
    const PreviousOrders(),
    const InfoPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            fixedColor: Colors.green,
            unselectedItemColor: Colors.grey,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.backup_table_rounded,
                  color: Colors.green,
                ),
                label: 'HOME',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.article_rounded,
                  color: Colors.green,
                ),
                label: 'ACTIVE ORDER',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.archive_rounded,
                  color: Colors.green,
                ),
                label: 'HISTORY',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.info_outline_rounded,
                  color: Colors.green,
                ),
                label: 'INFO',
              )
            ]));
  }
}
