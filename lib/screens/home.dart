import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  User? user = FirebaseAuth.instance.currentUser;

  var moods = [
    {
      'imgName': 'assets/icons/1.png',
      'title': 'ดีมาก',
      'index': 1,
    },
    {
      'imgName': 'assets/icons/2.png',
      'title': 'ดี',
      'index': 2,
    },
    {
      'imgName': 'assets/icons/3.png',
      'title': 'ปานกลาง',
      'index': 3,
    },
    {
      'imgName': 'assets/icons/4.png',
      'title': 'แย่',
      'index': 4,
    },
    {
      'imgName': 'assets/icons/5.png',
      'title': 'แย่มาก',
      'index': 5,
    },
  ];

  final weekday = [
    "วันจันทร์",
    "วันอังคาร",
    "วันพุธ",
    "วันพฤหัสบดี",
    "วันศุกร์",
    "วันเสาร์",
    "วันอาทิตย์"
  ];

  getWeekday(int day) {
    return weekday[day - 1];
  }

  final month = [
    "มกราคม",
    "กุมภาพันธ์",
    "มีนาคม",
    "เมษายน",
    "พฤษภาคม",
    "มิถุนายน",
    "กรกฎาคม",
    "สิงหาคม",
    "กันยายน",
    "ตุลาคม",
    "พฤศจิกายน",
    "ธันวาคม"
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
              .where('createdBy', isEqualTo: user!.uid)
              .orderBy('dateTime', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Palette.primary)),
              );
            }
            return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final json = snapshot.data!.docs[index];
                  final diary =
                      Diary.fromJson(json.data() as Map<String, dynamic>);
                  return Column(
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
                                          height: 150,
                                          color: Palette.secondary,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(
                                                    '${(diary.dateTime.day)} ${getWeekday(diary.dateTime.weekday)} ${getMonth(diary.dateTime.month)}',
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
                                                                .pen,
                                                            color: Palette
                                                                    .secondary[
                                                                300]),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          'แก้ไขไดอารี่',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 24),
                                                        ),
                                                      ],
                                                    ),
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    DetailDiary(
                                                                      id: diary
                                                                          .id,
                                                                      mood: diary
                                                                          .mood,
                                                                      moodScore:
                                                                          diary
                                                                              .moodScore,
                                                                      sleep: diary
                                                                          .sleep,
                                                                      food: diary
                                                                          .food,
                                                                      water: diary
                                                                          .water,
                                                                      exercise:
                                                                          diary
                                                                              .exercise,
                                                                      note: diary
                                                                          .note,
                                                                    )),
                                                      );
                                                    }),
                                                TextButton(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      FaIcon(
                                                          FontAwesomeIcons
                                                              .timesCircle,
                                                          color: Colors.red),
                                                      SizedBox(width: 10),
                                                      Text(
                                                        'ปิด',
                                                        style: TextStyle(
                                                            color: Colors.black,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                      '${moods.where((item) {
                                        return item["index"] == diary.moodScore;
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
                            GridView.count(
                              shrinkWrap: true,
                              crossAxisSpacing: 0.0,
                              mainAxisSpacing: 0.0,
                              childAspectRatio: 4,
                              crossAxisCount: 2,
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                Row(
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
                                Row(
                                  children: [
                                    Icon(
                                      Icons.local_drink,
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
                                        overflow: TextOverflow.ellipsis,
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
                                      "•  ${diary.note}",
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
                      SizedBox(height: 10)
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
}
