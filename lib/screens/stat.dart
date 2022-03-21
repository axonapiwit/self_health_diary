import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:self_health_diary/themes/colors.dart';
import 'package:self_health_diary/services/bar_chart.dart';
import 'package:self_health_diary/services/line_chart.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';

class StatScreen extends StatefulWidget {
  const StatScreen({Key? key}) : super(key: key);

  @override
  _StatScreenState createState() => _StatScreenState();
}

List<DateTime> GreatDate = [];
List<DateTime> GoodDate = [];
List<DateTime> MehDate = [];
List<DateTime> BadDate = [];
List<DateTime> AwfulDate = [];

class _StatScreenState extends State<StatScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  CalendarFormat format = CalendarFormat.month;

  getCalendar(List allData) {
    GreatDate.clear();
    GoodDate.clear();
    MehDate.clear();
    BadDate.clear();
    AwfulDate.clear();
    allData.forEach((element) {
      var day = (element['dateTime'] as Timestamp).toDate().day;
      var month = (element['dateTime'] as Timestamp).toDate().month;
      var year = (element['dateTime'] as Timestamp).toDate().year;
      if (element['moodScore'] == 1) {
        GreatDate.add(DateTime(year, month, day));
      }
      if (element['moodScore'] == 2) {
        GoodDate.add(DateTime(year, month, day));
      }
      if (element['moodScore'] == 3) {
        MehDate.add(DateTime(year, month, day));
      }
      if (element['moodScore'] == 4) {
        BadDate.add(DateTime(year, month, day));
      }
      if (element['moodScore'] == 5) {
        AwfulDate.add(DateTime(year, month, day));
      }
    });

    _markedDateMap.clear();

    for (int i = 0; i < GreatDate.length; i++) {
      _markedDateMap.add(
        GreatDate[i],
        new Event(
          date: GreatDate[i],
          title: 'Event 5',
          icon: _Great(
            GreatDate[i].day.toString(),
          ),
        ),
      );
    }

    for (int i = 0; i < GoodDate.length; i++) {
      _markedDateMap.add(
        GoodDate[i],
        new Event(
          date: GoodDate[i],
          title: 'Event 5',
          icon: _Good(
            GoodDate[i].day.toString(),
          ),
        ),
      );
    }

    for (int i = 0; i < MehDate.length; i++) {
      _markedDateMap.add(
        MehDate[i],
        new Event(
          date: MehDate[i],
          title: 'Event 5',
          icon: _Meh(
            MehDate[i].day.toString(),
          ),
        ),
      );
    }

    for (int i = 0; i < BadDate.length; i++) {
      _markedDateMap.add(
        BadDate[i],
        new Event(
          date: BadDate[i],
          title: 'Event 5',
          icon: _Bad(
            BadDate[i].day.toString(),
          ),
        ),
      );
    }

    for (int i = 0; i < AwfulDate.length; i++) {
      _markedDateMap.add(
        AwfulDate[i],
        new Event(
          date: AwfulDate[i],
          title: 'Event 5',
          icon: _Awful(
            AwfulDate[i].day.toString(),
          ),
        ),
      );
    }
    // setState(() {});
  }

  static Widget _Great(String day) => CircleAvatar(
        backgroundColor: Colors.green,
        child: Text(
          day,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );

  static Widget _Good(String day) => CircleAvatar(
        backgroundColor: Colors.yellow,
        child: Text(
          day,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );

  static Widget _Meh(String day) => CircleAvatar(
        backgroundColor: Colors.orange,
        child: Text(
          day,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );

  static Widget _Bad(String day) => CircleAvatar(
        backgroundColor: Colors.red,
        child: Text(
          day,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );

  static Widget _Awful(String day) => CircleAvatar(
        backgroundColor: Colors.purple,
        child: Text(
          day,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );

  late CalendarCarousel _calendarCarouselNoHeader;
  late double cHeight;

  @override
  Widget build(BuildContext context) {
    cHeight = MediaQuery.of(context).size.height;

    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      height: cHeight * 0.56,
      weekendTextStyle: TextStyle(
        color: Colors.black,
      ),
      todayButtonColor: Colors.blue,
      daysTextStyle: TextStyle(color: Colors.black),
      markedDatesMap: _markedDateMap,
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      locale: 'th_TH',
      markedDateMoreShowTotal:
          null, // null for not showing hidden events indicator
      markedDateIconBuilder: (event) {
        return event.icon;
      },
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.tertiary,
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('diaries')
              .where('createdBy', isEqualTo: user!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Palette.primary)),
              );
            }
            getCalendar(snapshot.data!.docs.map((doc) => doc.data()).toList());
            return SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _calendarCarouselNoHeader,
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisSpacing: 0.0,
                        mainAxisSpacing: 0.0,
                        childAspectRatio: 4,
                        crossAxisCount: 2,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          markerRepresent(Colors.green, "1 ดีมาก"),
                          markerRepresent(Colors.yellow, "2 ดี"),
                          markerRepresent(Colors.orange, "3 ปานกลาง"),
                          markerRepresent(Colors.red, "4 แย่"),
                          markerRepresent(Colors.purple, "5 แย่มาก"),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: LineChartOne(),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: BarChartOne(),
                  ),
                  SizedBox(height: 5),
                  Container(
                      child: Column(
                    children: <Widget>[
                      Text(
                        'เกณฑ์วัดอารมณ์',
                        style: TextStyle(fontSize: 20),
                      ),
                      barChartDescript("assets/icons/5.png",
                          "28 - 35 คะแนน มีความเครียดสูง"),
                      barChartDescript("assets/icons/4.png",
                          "21 - 27 คะแนน สงสัยว่ามีความเครียด"),
                      barChartDescript(
                          "assets/icons/1.png", "1 - 20 คะแนน ไม่มีความเครียด"),
                    ],
                  )),
                  SizedBox(height: 25),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget markerRepresent(Color color, String data) {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        radius: cHeight * 0.022,
      ),
      title: new Text(
        data,
      ),
    );
  }

  Widget barChartDescript(String img, String data) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Image.asset(
            img,
            height: 35,
          ),
          SizedBox(width: 20),
          Text(
            data,
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}
