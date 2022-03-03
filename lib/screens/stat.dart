import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:self_health_diary/models/diary.dart';
import 'package:self_health_diary/themes/colors.dart';
import 'package:self_health_diary/widgets/bar_chart.dart';
import 'package:self_health_diary/widgets/line_chart.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:math';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';

class StatScreen extends StatefulWidget {
  const StatScreen({Key? key}) : super(key: key);

  @override
  _StatScreenState createState() => _StatScreenState();
}

List<DateTime> ExcellenceDate = [
  DateTime(2022, 03, 1),
  DateTime(2022, 03, 3),
  DateTime(2022, 03, 4),
  DateTime(2022, 03, 5),
  DateTime(2022, 03, 6),
  DateTime(2022, 03, 9),
  DateTime(2022, 03, 10),
  DateTime(2022, 03, 11),
  DateTime(2022, 03, 15),
  DateTime(2022, 03, 22),
  DateTime(2022, 03, 23),
];
List<DateTime> BadlyDate = [
  DateTime(2022, 03, 2),
  DateTime(2022, 03, 7),
  DateTime(2022, 03, 8),
  DateTime(2022, 03, 12),
  DateTime(2022, 03, 13),
  DateTime(2022, 03, 14),
  DateTime(2022, 03, 16),
  DateTime(2022, 03, 17),
  DateTime(2022, 03, 18),
  DateTime(2022, 03, 19),
  DateTime(2022, 03, 20),
];
List<DateTime> VeryBadDate = [
  DateTime(2022, 03, 30),
  DateTime(2022, 03, 29),
  DateTime(2022, 03, 29),
];

class _StatScreenState extends State<StatScreen> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  List<Diary> moodsList = [
    Diary(mood: 'Good', moodScore: 3, dateTime: DateTime.parse('2022-02-22'))
  ];

  var moodsColor = [
    {
      'color': Colors.green,
      'index': 4,
    },
    {
      'color': Colors.amber,
      'index': 3,
    },
    {
      'color': Colors.orangeAccent,
      'index': 2,
    },
    {
      'color': Colors.redAccent,
      'index': 1,
    },
    {
      'color': Colors.purpleAccent,
      'index': 0,
    },
  ];

  static Widget _Excellence(String day) => CircleAvatar(
        backgroundColor: Colors.green,
        child: Text(
          day,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );

  static Widget _Badly(String day) => CircleAvatar(
        backgroundColor: Colors.red,
        child: Text(
          day,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );

  static Widget _VeryBad(String day) => CircleAvatar(
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

  var len = min(BadlyDate.length, ExcellenceDate.length);
  var len2 = min(ExcellenceDate.length, VeryBadDate.length);
  late double cHeight;
  @override
  Widget build(BuildContext context) {
    cHeight = MediaQuery.of(context).size.height;

    for (int i = 0; i < len; i++) {
      _markedDateMap.add(
        ExcellenceDate[i],
        new Event(
          date: ExcellenceDate[i],
          title: 'Event 5',
          icon: _Excellence(
            ExcellenceDate[i].day.toString(),
          ),
        ),
      );
    }

    for (int i = 0; i < len; i++) {
      _markedDateMap.add(
        BadlyDate[i],
        new Event(
          date: BadlyDate[i],
          title: 'Event 5',
          icon: _Badly(
            BadlyDate[i].day.toString(),
          ),
        ),
      );
    }

    for (int i = 0; i < len2; i++) {
      _markedDateMap.add(
        VeryBadDate[i],
        new Event(
          date: VeryBadDate[i],
          title: 'Event 5',
          icon: _VeryBad(
            VeryBadDate[i].day.toString(),
          ),
        ),
      );
    }

    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      height: cHeight * 0.54,
      weekendTextStyle: TextStyle(
        color: Colors.black,
      ),
      todayButtonColor: Colors.blue,
      daysTextStyle: TextStyle(color: Colors.black),
      markedDatesMap: _markedDateMap,
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
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
          stream: FirebaseFirestore.instance.collection('diaries').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Palette.primary)),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _calendarCarouselNoHeader,
                      markerRepresent(Colors.green, "Exellent"),
                      markerRepresent(Colors.yellow, "Good"),
                      markerRepresent(Colors.orange, "Medium"),
                      markerRepresent(Colors.red, "Badly"),
                      markerRepresent(Colors.purple, "Very Bad"),
                    ],
                  ),
                  // Container(
                  //   padding: EdgeInsets.all(20),
                  //   child: TableCalendar(
                  //     firstDay: DateTime.utc(1990),
                  //     lastDay: DateTime.utc(2050),
                  //     focusedDay: selectedDay,
                  //     calendarFormat: format,
                  //     onFormatChanged: (CalendarFormat _format) {
                  //       setState(() {
                  //         format = _format;
                  //       });
                  //     },
                  //     startingDayOfWeek: StartingDayOfWeek.sunday,
                  //     daysOfWeekVisible: true,
                  //     onDaySelected: (
                  //       DateTime selectDay,
                  //       DateTime focuseDay,
                  //     ) {
                  //       setState(() {
                  //         selectedDay = selectDay;
                  //         focusedDay = focuseDay;
                  //       });
                  //     },
                  //     holidayPredicate: (day) {
                  //       final n = [3,4];
                  //       return n.contains(day.day);
                  //     },

                  //     selectedDayPredicate: (DateTime date) {
                  //       // return isSameDay(selectedDay, date);

                  //       final resault =
                  //           moodsList.where((m) => isSameDay(m.dateTime, date));
                  //       // print(resault.isNotEmpty);
                  //       // print(date.toString());

                  //       return resault.isNotEmpty;
                  //     },
                  //     calendarStyle: CalendarStyle(
                  //       isTodayHighlighted: true,
                  //       selectedDecoration: BoxDecoration(
                  //         color: Colors.amber,
                  //         shape: BoxShape.circle,
                  //       ),
                  //       selectedTextStyle: TextStyle(color: Colors.white),
                  //       todayDecoration: BoxDecoration(
                  //         color: Palette.primary,
                  //         shape: BoxShape.circle,
                  //       ),
                  //     ),
                  //     headerStyle: HeaderStyle(
                  //       formatButtonVisible: true,
                  //       titleCentered: true,
                  //       formatButtonShowsNext: false,
                  //       formatButtonDecoration: BoxDecoration(
                  //         color: Palette.primary,
                  //         borderRadius: BorderRadius.circular(5.0),
                  //       ),
                  //       formatButtonTextStyle: TextStyle(
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //     // eventLoader: ,
                  //   ),
                  // ),
                  SizedBox(height: 20),
                  Center(
                    child: LineChartOne(),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: BarChartOne(),
                  )
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
}
