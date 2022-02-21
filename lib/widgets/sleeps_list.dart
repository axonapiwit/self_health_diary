import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:self_health_diary/themes/colors.dart';

class SleepsList extends StatefulWidget {
  const SleepsList({Key? key, required this.onChange}) : super(key: key);

  final void Function(String, int) onChange;

  @override
  _SleepsListState createState() => _SleepsListState();
}

class _SleepsListState extends State<SleepsList> {
  var sleeps = [
    {
      'imgName': 'assets/icons/sleeping0.png',
      'title': '7-8 Hrs',
      'index': 0,
    },
    {
      'imgName': 'assets/icons/sleeping1.png',
      'title': '5-6 Hrs',
      'index': 1,
    },
    {
      'imgName': 'assets/icons/sleeping2.png',
      'title': '3-4 Hrs',
      'index': 2,
    },
    {
      'imgName': 'assets/icons/tired.png',
      'title': "Didn't Sleep",
      'index': 3,
    },
  ];

  int? isSleep = null;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sleep',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: ListView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: sleeps
                  .map<Widget>((s) => GestureDetector(
                        onTap: () {
                          widget.onChange(
                              s["title"] as String, s["index"] as int);
                          setState(() {
                            isSleep = s["index"] as int;
                          });

                          developer.log(s["index"].toString());
                        },
                        child: Row(
                          children: [
                            AnimatedContainer(
                                width: MediaQuery.of(context).size.width / 4,
                                height: MediaQuery.of(context).size.height / 8,
                                duration: Duration(seconds: 2),
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                  child: Center(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        '${s["imgName"]}',
                                        height: 60,
                                      ),
                                      Text(
                                        '${s["title"]}',
                                        style: TextStyle(
                                            color:
                                                (isSleep == s["index"] as int)
                                                    ? Colors.white
                                                    : Colors.black,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )),
                                  decoration: (isSleep == s["index"] as int)
                                      ? BoxDecoration(
                                          color: Color(0xFF56C956),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey.shade200,
                                                spreadRadius: 2.0),
                                            BoxShadow(
                                                color: Colors.white,
                                                spreadRadius: 2.0)
                                          ],
                                        )
                                      : BoxDecoration(
                                          color: Palette.secondary,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey.shade200,
                                                spreadRadius: 2.0),
                                            BoxShadow(
                                                color: Colors.white,
                                                spreadRadius: 2.0)
                                          ],
                                        ),
                                )),
                            SizedBox(width: 10)
                          ],
                        ),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
