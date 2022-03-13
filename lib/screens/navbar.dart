import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:self_health_diary/models/diary.dart';
import 'package:self_health_diary/screens/stat.dart';
import 'package:self_health_diary/screens/home.dart';
import 'package:self_health_diary/screens/diary.dart';
import 'package:self_health_diary/screens/menu.dart';
import 'package:self_health_diary/screens/profile.dart';
import 'package:self_health_diary/themes/colors.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  User? user = FirebaseAuth.instance.currentUser;

  int currentTab = 0;
  final List<Widget> screens = [
    HomeScreen(),
    StatScreen(),
    ProfileScreen(),
    MenuScreen(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomeScreen();

  validateCanAdd(List<QueryDocumentSnapshot<Object?>> json) {
    if (json.isEmpty) return true;
    final diary = Diary.fromJson(json.first);
    final date = diary.dateTime;
    final difference = DateTime.now().difference(date).inDays;
    return (difference >= 0 && (date.day != DateTime.now().day));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('diaries')
            .where('createdBy', isEqualTo: user!.uid)
            .orderBy('dateTime', descending: true)
            .snapshots(),
        builder: (conetext, snap) {
          if (snap.connectionState == ConnectionState.waiting)
            return Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          return Scaffold(
            body: PageStorage(
              child: currentScreen,
              bucket: bucket,
            ),
            floatingActionButton: FloatingActionButton(
              child: validateCanAdd(snap.data!.docs)
                  ? Icon(Icons.add, size: 40)
                  : Icon(
                      Icons.cancel,
                      size: 40,
                      color: Colors.white,
                    ),
              backgroundColor: validateCanAdd(snap.data!.docs)
                  ? Palette.primary
                  : Colors.black,
              onPressed: () {
                if (validateCanAdd(snap.data!.docs))
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DiaryScreen(),
                    ),
                  );
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
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
                              FaIcon(
                                FontAwesomeIcons.home,
                                size: 30,
                                color: currentTab == 0
                                    ? Palette.primary
                                    : Colors.grey.shade600,
                              ),
                              Text(
                                'หน้าหลัก',
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
                              FaIcon(
                                FontAwesomeIcons.chartPie,
                                size: 30,
                                color: currentTab == 1
                                    ? Palette.primary
                                    : Colors.grey.shade600,
                              ),
                              Text(
                                'สถิติ',
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
                              currentScreen = ProfileScreen();
                              currentTab = 3;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.userAlt,
                                size: 30,
                                color: currentTab == 3
                                    ? Palette.primary
                                    : Colors.grey.shade600,
                              ),
                              Text(
                                'โปรไฟล์',
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
                              currentScreen = MenuScreen();
                              currentTab = 4;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.bars,
                                size: 30,
                                color: currentTab == 4
                                    ? Palette.primary
                                    : Colors.grey.shade600,
                              ),
                              Text(
                                'รายการ',
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
        });
  }
}
