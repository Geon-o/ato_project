import 'package:ato/component_form/main_page_form/main_page_form.dart';
import 'package:ato/page/main_page.dart';
import 'package:ato/test/test_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBar();
}

class _BottomBar extends State<BottomBar>{

  int _selectedViewPageInx = 0;
  Color _color = Colors.lightBlue;

  static List _pages = [
    MainPageForm(),
    TestPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages[_selectedViewPageInx],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: _color,
        unselectedItemColor: Colors.blueGrey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        iconSize: 20,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        currentIndex: _selectedViewPageInx,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: "일기쓰기",
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedViewPageInx = index;
    });
  }
}