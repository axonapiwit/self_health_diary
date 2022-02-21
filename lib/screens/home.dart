import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:self_health_diary/models/diary.dart';
import 'package:self_health_diary/screens/detail_diary.dart';
import 'package:self_health_diary/themes/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var moods = [
    {
      'imgName': 'assets/icons/excellence.png',
      'title': 'Excellence',
    },
    {
      'imgName': 'assets/icons/good.png',
      'title': 'Good',
    },
    {
      'imgName': 'assets/icons/meduim.png',
      'title': 'Meduim',
    },
    {
      'imgName': 'assets/icons/badly.png',
      'title': 'Badly',
    },
    {
      'imgName': 'assets/icons/verybad.png',
      'title': 'Very Bad',
    },
  ];

  final weekday = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  getWeekday(int day) {
    return weekday[day - 1];
  }

  final month = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  getMonth(int months) {
    return month[months - 1];
  }

  checkZero(int num) {
    return num < 10 ? "0$num" : num;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.tertiary,
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('diaries')
              .orderBy('dateTime',descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow)),
              );
            }
            return ListView.builder(
                padding: EdgeInsets.all(15),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final json = snapshot.data!.docs[index];
                  final diary =
                      Diary.fromJson(json.data() as Map<String, dynamic>);
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Palette.secondary[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      '${(diary.dateTime.day)} ${getWeekday(diary.dateTime.weekday)} ${getMonth(diary.dateTime.month)}',
                                      style: TextStyle(fontSize: 20)),
                                  InkWell(
                                    child: FaIcon(FontAwesomeIcons.ellipsisH),
                                    onTap: () {
                                      showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            height: 200,
                                            color: Palette.secondary,
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Text('${diary.mood}',
                                                      style: TextStyle(
                                                          fontSize: 24)),
                                                  TextButton(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          FaIcon(
                                                              FontAwesomeIcons
                                                                  .book,
                                                              color: Palette
                                                                      .secondary[
                                                                  300]),
                                                          SizedBox(width: 10),
                                                          Text(
                                                            'Edit Diary',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 24),
                                                          ),
                                                        ],
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                DetailDiary(
                                                                    mood: diary
                                                                        .mood,
                                                                    sleep: diary
                                                                        .sleep,
                                                                    id: diary
                                                                        .id),
                                                          ),
                                                        );
                                                      }),
                                                  TextButton(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        FaIcon(
                                                            FontAwesomeIcons
                                                                .timesCircle,
                                                            color: Colors.red),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          'Close',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 24),
                                                        ),
                                                      ],
                                                    ),
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Image.asset(
                                        '${moods.where((item) {
                                          return item["title"] == diary.mood;
                                        }).toList()[0]["imgName"]}',
                                        height: 60,
                                      ),
                                    ],
                                  ),
                                  Text('${diary.mood}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      '${diary.dateTime.hour}:${checkZero(diary.dateTime.minute)}',
                                      style: TextStyle(
                                        fontSize: 18,
                                      )),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('99', style: TextStyle(fontSize: 39)),
                                  Text('Score', style: TextStyle(fontSize: 29)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.bed,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 10),
                                      Text('• ${diary.sleep}',
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
                                      Text('• ${diary.food}',
                                          style: TextStyle(
                                            fontSize: 18,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.water,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 10),
                                      Text('• ${diary.water}',
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
                                      Text('• ${diary.exercise}',
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
                      ),
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
}
