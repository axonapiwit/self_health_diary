import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:self_health_diary/screens/home.dart';
import 'package:self_health_diary/screens/login.dart';
import 'package:self_health_diary/themes/colors.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Login(),
    HomeScreen(),
    HomeScreen(),
    Login(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: Colors.green.shade50,
          bottomNavigationBar: BottomAppBar(
            child: BottomNavigationBar(
                showSelectedLabels: true,
                showUnselectedLabels: true,
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                        size: 40,
                        color: Colors.grey.shade600,
                      ),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.equalizer_outlined,
                        size: 40,
                        color: Colors.grey.shade600,
                      ),
                      label: 'Stat'),
                  BottomNavigationBarItem(
                      icon: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Palette.primary, shape: BoxShape.circle),
                          padding: EdgeInsets.all(14),
                          child: Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                      label: 'Diary'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.event_outlined,
                        size: 40,
                        color: Colors.grey.shade600,
                      ),
                      label: 'Events'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.settings_outlined,
                        size: 40,
                        color: Colors.grey.shade600,
                      ),
                      label: 'Setting'),
                ],
                onTap: _onItemTap),
          ),
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ),
      ),
    );
  }
}
