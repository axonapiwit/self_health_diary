import 'package:flutter/material.dart';
import 'package:self_health_diary/screens/event.dart';
import 'package:self_health_diary/screens/home.dart';
import 'package:self_health_diary/screens/diary.dart';
import 'package:self_health_diary/screens/more.dart';
import 'package:self_health_diary/screens/stat.dart';
import 'package:self_health_diary/themes/colors.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentTab = 0;
  final List<Widget> screens = [
    HomeScreen(),
    StatScreen(),
    EventScreen(),
    MoreScreen(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 40),
        backgroundColor: Palette.primary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DiaryScreen(),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        // shape: CircularNotchedRectangle(),
        // notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = HomeScreen();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          size: 35,
                          color: currentTab == 0
                              ? Palette.primary
                              : Colors.grey.shade600,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: currentTab == 0
                                ? Palette.primary
                                : Colors.grey.shade600,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = StatScreen();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.equalizer_outlined,
                          size: 35,
                          color: currentTab == 1
                              ? Palette.primary
                              : Colors.grey.shade600,
                        ),
                        Text(
                          'Stat',
                          style: TextStyle(
                            color: currentTab == 1
                                ? Palette.primary
                                : Colors.grey.shade600,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = EventScreen();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_outlined,
                          size: 35,
                          color: currentTab == 3
                              ? Palette.primary
                              : Colors.grey.shade600,
                        ),
                        Text(
                          'Event',
                          style: TextStyle(
                            color: currentTab == 3
                                ? Palette.primary
                                : Colors.grey.shade600,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = MoreScreen();
                        currentTab = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.settings,
                          size: 35,
                          color: currentTab == 4
                              ? Palette.primary
                              : Colors.grey.shade600,
                        ),
                        Text(
                          'More',
                          style: TextStyle(
                            color: currentTab == 4
                                ? Palette.primary
                                : Colors.grey.shade600,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
