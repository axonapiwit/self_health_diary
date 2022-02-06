import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sunday, Jan', style: TextStyle(fontSize: 20)),
                      FaIcon(FontAwesomeIcons.ellipsisH),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'assets/icons/good.png',
                            height: 60,
                          ),
                        ],
                      ),
                      Text('Good',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('09:00',
                          style: TextStyle(
                            fontSize: 18,
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('81', style: TextStyle(fontSize: 39)),
                      Text('Score', style: TextStyle(fontSize: 29)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            FontAwesomeIcons.bed,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text('• 7-8 Hrs',
                              style: TextStyle(
                                fontSize: 18,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.utensils,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text('• 3 Meals',
                              style: TextStyle(
                                fontSize: 18,
                              )),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.water,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text('• 1.5 Liter',
                              style: TextStyle(
                                fontSize: 18,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.dumbbell,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text('• 30 Min',
                              style: TextStyle(
                                fontSize: 18,
                              )),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.book,
                        size: 20,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Container(
                          child: Text(
                            "• Today's exam was very tiring but I was able to pass it.",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
