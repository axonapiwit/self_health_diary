import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:self_health_diary/themes/colors.dart';

class BarChartOne extends StatefulWidget {
  const BarChartOne({Key? key}) : super(key: key);

  @override
  _BarChartOneState createState() => _BarChartOneState();
}

class _BarChartOneState extends State<BarChartOne> {
  final Color barBackgroundColor = const Color(0xff72d8bf);
  int touchedIndex = -1;
  User? user = FirebaseAuth.instance.currentUser;
  final moodScore = [];
  List<BarChartGroupData> showingGroups = [];
  List<int> moodScores = [];

  getBarChart() async {
    final now = DateTime.now();
    final startDate = now.subtract(Duration(days: 21));
    final sunday = startDate.subtract(Duration(days: now.weekday));
    final data = await FirebaseFirestore.instance
        .collection('diaries')
        .where('createdBy', isEqualTo: user!.uid)
        .orderBy('dateTime')
        .where("dateTime",
            isGreaterThan: DateTime(sunday.year, sunday.month, sunday.day))
        .get();

    // key = Start of week day, values = list
    Map<DateTime, List<Map<String, dynamic>>> weekMap = {};
    final json = data.docs.map((e) => e.data()).toList();

    if (json.isEmpty) return true;
    // range firstDate to lastItem
    final _dayDiff = DateTime(sunday.year, sunday.month, sunday.day)
        .difference(DateTime(now.year, now.month, now.day));

    // range week count
    int range = (_dayDiff.inDays.abs() / 7).ceil();

    for (int i = 0; i < range; i++) {
      final _date = sunday.add(Duration(days: i * 7));
      weekMap[_date] = [];
      for (int j = 0; j < json.length; j++) {
        // check date at loop with sunday
        final eldate = (json[j]["dateTime"].toDate() as DateTime);
        final __date = DateTime(eldate.year, eldate.month, eldate.day)
            .difference(DateTime(_date.year, _date.month, _date.day))
            .inDays;
        // range in week
        print('el${json[j]["dateTime"].toDate()}');
        print('week${_date}');
        print('dif${__date}');
        print('Sun${sunday}');
        print('-----');
        if (__date <= 6 && __date >= 0) {
          weekMap[_date]!.add(json[j]);
        }
      }
    }
    List<int> scores = weekMap.values.map((e) {
      int _sum = 0;
      e.forEach((u) => _sum += u["moodScore"] as int);
      return _sum;
    }).toList();
    if (scores.length > 4) {
      scores = scores.skip(scores.length - 4).toList();
    }

    moodScores = scores;
    setState(() {});
  }

  @override
  void initState() {
    getBarChart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Palette.tertiary[200],
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '?????????????????????????????????????????????????????????????????????????????????????????????',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: BarChart(mainBarData()),
              ),
            ),
          ],
        ),
      ),
      Positioned(
          bottom: 52,
          left: 14,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Image.asset(
                  'assets/icons/9.png',
                  width: 30,
                ),
              ),
              SizedBox(height: 36),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Image.asset(
                  'assets/icons/8.png',
                  width: 30,
                ),
              ),
              SizedBox(height: 50),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Image.asset(
                  'assets/icons/7.png',
                  width: 30,
                ),
              ),
            ],
          )),
    ]);
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.deepPurpleAccent,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.black] : [barColor], // ??????????????????
          width: width,
          borderSide: isTouched
              ? BorderSide(color: Colors.amber, width: 1) // ???????????????????????????
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 37,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroupsFn() {
    final List<BarChartGroupData> arr = [];
    for (int i = 0; i < moodScores.length; i++) {
      arr.add(makeGroupData(i, moodScores[i].toDouble(),
          isTouched: i == touchedIndex));
    }
    return arr;
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekly;
              switch (group.x.toInt()) {
                case 0:
                  weekly = '3 ??????????????????????????????????????????';
                  break;
                case 1:
                  weekly = '2 ??????????????????????????????????????????';
                  break;
                case 2:
                  weekly = '1 ??????????????????????????????????????????';
                  break;
                case 3:
                  weekly = '??????????????????????????????';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekly + '\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toString(),
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return '3';
              case 1:
                return '2';
              case 2:
                return '1';
              case 3:
                return '??????????????????????????????';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      maxY: 37,
      minY: 7,
      barGroups: showingGroupsFn(),
      gridData: FlGridData(show: false),
    );
  }
}
