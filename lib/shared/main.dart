import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'category.dart';
import 'find_icon.dart';
import 'qna.dart';



class MyApp extends StatefulWidget {
  MyApp({Key?key}):super(key:key);




  @override
  _MyApp createState() => _MyApp();

}

class _MyApp extends State<MyApp> {
  int _selectedIndex = 0;

  static List<Widget> pages = <Widget>[
    FindIcon(),
    Cartegory(),
    Qna()
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
          title: Text('trash'),
        ),
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.grey,
          items: [
            const BottomNavigationBarItem(icon: Icon(Icons.home),label: ''),
            const BottomNavigationBarItem(icon: Icon(Icons.recycling),label: ''),
            const BottomNavigationBarItem(icon: Icon(Icons.question_mark),label: ''),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        )
    );

  }
}