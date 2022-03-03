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

  getChart() {
    print('ben');
    List<Map<String, dynamic>> allData;
    FirebaseFirestore.instance
        .collection('diaries')
        .where('createdBy', isEqualTo: user!.uid)
        .get()
        .then((value) {
      print(value.docs);
      allData = value.docs.map((doc) =>
          // spot.push(FlSpot(doc.data()['moodScore']),
          //     FlSpot(doc.data()['moodScore']))
          doc.data()).toList();
      print(allData[0]);
      allData.map((e) => moodScore.add(e['moodScore']));
      print('ss$moodScore');

      double i = 0;
      allData.forEach((element) {
        print(element['moodScore'].runtimeType);
        spot.add(FlSpot(i, (element['moodScore'] as int).toDouble()));
        i += 2.0;
      });
      // spot = moodScore.asMap().entries.map((e) {
      //   return FlSpot(e.key.toDouble(), e.value);
      // }).toList();
      print(spot);
      setState(() {});
    });
  }

  @override
  void initState() {
    getChart();
    print(spot);
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
                'Moods Chart',
                style: TextStyle(color: Colors.black, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                'Moods Chart in one weekend',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
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
            bottom: 40,
            left: 14,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Image.asset(
                    'assets/icons/5.png',
                    width: 30,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Image.asset(
                    'assets/icons/4.png',
                    width: 30,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Image.asset(
                    'assets/icons/3.png',
                    width: 30,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Image.asset(
                    'assets/icons/2.png',
                    width: 30,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Image.asset(
                    'assets/icons/1.png',
                    width: 30,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Image.asset(
                    'assets/icons/0.png',
                    width: 30,
                  ),
                ),
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
                  return 'Sun';
                case 2:
                  return 'Mon';
                case 4:
                  return 'Tue';
                case 6:
                  return 'Wed';
                case 8:
                  return 'Thu';
                case 10:
                  return 'Fri';
                case 12:
                  return 'Sat';
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
