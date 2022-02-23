// ignore: unused_import
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:self_health_diary/themes/colors.dart';

class BarChartOne extends StatefulWidget {
  const BarChartOne({Key? key}) : super(key: key);
  final List<Color> availableColors = const [
    Colors.redAccent,
    Colors.yellow,
    Colors.pink,
    Colors.green,
    Colors.orange,
    Colors.lightBlue,
    Colors.purpleAccent,
  ];

  @override
  _BarChartOneState createState() => _BarChartOneState();
}

class _BarChartOneState extends State<BarChartOne> {
  final Color barBackgroundColor = const Color(0xff72d8bf);
  int touchedIndex = -1;
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Palette.tertiary[300],
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Analysis',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Weekly Moods',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: BarChart(mainBarData()),
              ),
            )
          ],
        ),
      ),
      Positioned(
          bottom: 36,
          left: 14,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Image.asset(
                  'assets/icons/excellence.png',
                  width: 30,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Image.asset(
                  'assets/icons/good.png',
                  width: 30,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Image.asset(
                  'assets/icons/medium.png',
                  width: 30,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Image.asset(
                  'assets/icons/badly.png',
                  width: 30,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Image.asset(
                  'assets/icons/verybad.png',
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
    Color barColor = Colors.blueAccent,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.black] : [barColor], // สีแท่ง
          width: width,
          borderSide: isTouched
              ? BorderSide(color: Colors.amber, width: 1) // สีขอบแท่ง
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 20,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 5, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, 6.5, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, 5, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, 7.5, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, 9, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, 11.5, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, 6.5, isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'Sunday';
                  break;
                case 1:
                  weekDay = 'Monday';
                  break;
                case 2:
                  weekDay = 'Tuesday';
                  break;
                case 3:
                  weekDay = 'Wednesday';
                  break;
                case 4:
                  weekDay = 'Thursday';
                  break;
                case 5:
                  weekDay = 'Friday';
                  break;
                case 6:
                  weekDay = 'Saturday';
                  break;

                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
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
                return 'S';
              case 1:
                return 'M';
              case 2:
                return 'T';
              case 3:
                return 'W';
              case 4:
                return 'T';
              case 5:
                return 'F';
              case 6:
                return 'S';
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
      // barGroups: List.generate(7, (i) {
      //   switch (i) {
      //     case 0:
      //       return makeGroupData(0, Random().nextInt(1).toDouble() + 6,
      //           barColor: widget.availableColors[
      //               Random().nextInt(widget.availableColors.length)]);
      //     case 1:
      //       return makeGroupData(1, Random().nextInt(15).toDouble() + 6,
      //           barColor: widget.availableColors[
      //               Random().nextInt(widget.availableColors.length)]);
      //     case 2:
      //       return makeGroupData(2, Random().nextInt(15).toDouble() + 6,
      //           barColor: widget.availableColors[
      //               Random().nextInt(widget.availableColors.length)]);
      //     case 3:
      //       return makeGroupData(3, Random().nextInt(15).toDouble() + 6,
      //           barColor: widget.availableColors[
      //               Random().nextInt(widget.availableColors.length)]);
      //     case 4:
      //       return makeGroupData(4, Random().nextInt(15).toDouble() + 6,
      //           barColor: widget.availableColors[
      //               Random().nextInt(widget.availableColors.length)]);
      //     case 5:
      //       return makeGroupData(5, Random().nextInt(15).toDouble() + 6,
      //           barColor: widget.availableColors[
      //               Random().nextInt(widget.availableColors.length)]);
      //     case 6:
      //       return makeGroupData(6, Random().nextInt(15).toDouble() + 6,
      //           barColor: widget.availableColors[
      //               Random().nextInt(widget.availableColors.length)]);
      //     default:
      //       return throw Error();
      //   }
      // }),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }
}
