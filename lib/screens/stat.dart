import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:self_health_diary/themes/colors.dart';
import 'package:table_calendar/table_calendar.dart';

class StatScreen extends StatefulWidget {
  const StatScreen({Key? key}) : super(key: key);

  @override
  _StatScreenState createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.tertiary,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: TableCalendar(
                  firstDay: DateTime.utc(1990),
                  lastDay: DateTime.utc(2050),
                  focusedDay: selectedDay,
                  calendarFormat: format,
                  onFormatChanged: (CalendarFormat _format) {
                    setState(() {
                      format = _format;
                    });
                  },
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  daysOfWeekVisible: true,
                  onDaySelected: (DateTime selectDay, DateTime focuseDay) {
                    setState(() {
                      selectedDay = selectDay;
                      focusedDay = focuseDay;
                    });
                  },
                  selectedDayPredicate: (DateTime date) {
                    return isSameDay(selectedDay, date);
                  },
                  calendarStyle: CalendarStyle(
                    isTodayHighlighted: true,
                    selectedDecoration: BoxDecoration(
                      color: Palette.secondary[300],
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: TextStyle(color: Colors.white),
                    todayDecoration: BoxDecoration(
                      color: Palette.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: true,
                    titleCentered: true,
                    formatButtonShowsNext: false,
                    formatButtonDecoration: BoxDecoration(
                      color: Palette.primary,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    formatButtonTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    height: 320,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff2c274c),
                            Color(0xff246426c),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          'Moods Chart',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Moods Chart',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
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
                      ))
                ],
              ),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
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
            getTextStyles: (context, value) => TextStyle(color: Colors.white),
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
          getTextStyles: (context, value) => TextStyle(color: Colors.white),
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
      maxX: 14,
      minY: 0,
      maxY: 4,
      lineBarsData: linesBarData(),
    );
  }

  List<LineChartBarData> linesBarData() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
        spots: [
          FlSpot(0, 0),
          FlSpot(2, 1),
          FlSpot(4, 2),
          FlSpot(6, 4),
          FlSpot(10, 2),
          FlSpot(14, 4),
        ],
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
