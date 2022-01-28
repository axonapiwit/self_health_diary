import 'package:flutter/material.dart';
import 'package:self_health_diary/themes/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.tertiary,
        body: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Palette.secondary[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Sunday, Jan', style: TextStyle(fontSize: 20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/good.png',
                        height: 60,
                      ),
                      Text('Good',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('09:00'),
                    ],
                  ),
                  Text('7-8 Hrs'),
                  Text('3 Meals'),
                  Text('5-6 Glasses'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
