import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:self_health_diary/themes/colors.dart';

class LineChartOne extends StatefulWidget {
  const LineChartOne({Key? key}) : super(key: key);

  @override
  _LineChartOneState createState() => _LineChartOneState();
}

class _LineChartOneState extends State<LineChartOne> {
  User? user = FirebaseAuth.instance.currentUser;
  final moodScore = [];
  List<FlSpot> spot = [];

  getLineChart() {
    List<Map<String, dynamic>> allData;
    FirebaseFirestore.instance
        .collection('diaries')
        .where('createdBy', isEqualTo: user!.uid)
        .orderBy('dateTime')
        // .limitToLast(7)
        .get()
        .then((value) {
      allData = value.docs.map((doc) => doc.data()).toList();
      // print(allData.length);
      var now = DateTime.now();
      // final Map<int, int> dayMap = {};
      // for (int i = 0; i < 7; i++) {
      //   final currentDay = now.subtract(Duration(days: i));
      //   print(currentDay);
      //   // final dataDay = allData.firstWhere((element) => false)
      //   allData.forEach((element) {
      //     final elementDate = (element['dateTime'].toDate() as DateTime);
      //     final difDay = (DateTime(
      //             elementDate.year, elementDate.month, elementDate.day))
      //         .difference(
      //             DateTime(currentDay.year, currentDay.month, currentDay.day));
      //     print(currentDay);
      //     print(element['dateTime'].toDate());
      //     print(difDay.inDays);
      //     print('========');
      //     if (difDay.inDays == 0) {
      //       dayMap[7 - i] = (element['moodScore']) as int;
      //     }
      //   });
      // }
      // print(dayMap);
      // double j = 0;
      // for (double i = 0; i < 7; i++) {
      //   print(dayMap[i]);
      //   if (dayMap[i] != null) {
      //     spot.add(FlSpot(j, dayMap[i]!.toDouble()));
      //     j += 2.0;
      //   } else {
      //     spot.add(FlSpot(j, 0.0));
      //     j += 2.0;
      //   }
      // };

      //---------------------------

      var subList;

      if (allData.length > 7) {
        subList = allData.skip(allData.length - 7).take(7);
      } else {
        subList = allData;
      }
      subList.map((e) => moodScore.add(e['moodScore']));

      double i = 0;
      bool isTodayAdd = false;
      subList.forEach((element) {
        final elementDate = (element['dateTime'].toDate() as DateTime);
        final difDay =
            (DateTime(elementDate.year, elementDate.month, elementDate.day))
                .difference(DateTime(now.year, now.month, now.day));
        if (difDay.inDays == 0) {
          isTodayAdd = true;
        }
        // spot.add(FlSpot(i, (element['moodScore'] as int).toDouble()));
        // i += 2.0;
      });
      // print(isTodayAdd);
      if (isTodayAdd) {
        subList.forEach((element) {
          spot.add(FlSpot(i, (element['moodScore'] as int).toDouble()));
          i += 2.0;
        });
      } else {
        double j = 0.0;
        subList = subList.skip(1).toList();
        // print(subList.length);
        for (int i = 0; i < 6; i++) {
          spot.add(FlSpot(j, (subList[i]['moodScore'] as int).toDouble()));
          j += 2.0;
        }
      }

      setState(() {});
    });
  }

  @override
  void initState() {
    getLineChart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 350,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              gradient: LinearGradient(
                colors: [
                  Color(0xFF8ED8B1),
                  Color(0xFF9C8DAFF),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'กราฟแสดงอารมณ์ใน 7 วันล่าสุด',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 25,
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(right: 16, left: 6),
                child: LineChart(moodData()),
              )),
              SizedBox(height: 10)
            ],
          ),
        ),
        Positioned(
            bottom: 75,
            left: 14,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Image.asset(
                    'assets/icons/5.png',
                    width: 30,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Image.asset(
                    'assets/icons/4.png',
                    width: 30,
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Image.asset(
                    'assets/icons/3.png',
                    width: 30,
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Image.asset(
                    'assets/icons/2.png',
                    width: 30,
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Image.asset(
                    'assets/icons/1.png',
                    width: 30,
                  ),
                ),
                SizedBox(height: 5),
              ],
            )),
      ],
    );
  }

  LineChartData moodData() {
    return LineChartData(
      lineTouchData: LineTouchData(),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            getTextStyles: (context, value) => TextStyle(color: Colors.black),
            margin: 10,
            getTitles: (value) {
              switch (value.toInt()) {
                case 0:
                  return '1';
                case 2:
                  return '2';
                case 4:
                  return '3';
                case 6:
                  return '4';
                case 8:
                  return '5';
                case 10:
                  return '6';
                case 12:
                  return '7';
              }
              return '';
            }),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) =>
              TextStyle(color: Colors.transparent),
          margin: 8,
          reservedSize: 30,
        ),
        rightTitles: SideTitles(
          showTitles: false,
        ),
        topTitles: SideTitles(
          showTitles: false,
        ),
      ),
      // Border Line Chart
      borderData: FlBorderData(
          show: true,
          border: Border(
              bottom: BorderSide(color: Palette.primary, width: 4),
              left: BorderSide(
                color: Colors.transparent,
              ),
              right: BorderSide(
                color: Colors.transparent,
              ),
              top: BorderSide(
                color: Colors.transparent,
              ))),
      minX: 0,
      maxX: 12,
      minY: 0,
      maxY: 5,
      lineBarsData: linesBarData(),
    );
  }

  List<LineChartBarData> linesBarData() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
        // Left Day Right MoodScore
        spots: spot,
        // Curve Chart
        isCurved: false,
        barWidth: 8,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
        ));

    return [
      // This can show charts
      lineChartBarData1,
    ];
  }
}
