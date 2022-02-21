import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:self_health_diary/themes/colors.dart';

class WatersList extends StatefulWidget {
  const WatersList({Key? key, required this.onChange}) : super(key: key);

  final void Function(String, int) onChange;

  @override
  _SleepsListState createState() => _SleepsListState();
}

class _SleepsListState extends State<WatersList> {
  var waters = [
    {
      'imgName': 'assets/icons/water-bottle.png',
      'title': '2 Liter',
      'index': 0,
    },
    {
      'imgName': 'assets/icons/water-bottle1.png',
      'title': '1.5 Liter',
      'index': 1,
    },
    {
      'imgName': 'assets/icons/water-bottle2.png',
      'title': '1 Liter',
      'index': 2,
    },
    {
      'imgName': 'assets/icons/water1.png',
      'title': "0.5 Liter",
      'index': 3,
    },
  ];

  int? isWater = null;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Water',
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
              children: waters
                  .map<Widget>((w) => GestureDetector(
                        onTap: () {
                          widget.onChange(
                              w["title"] as String, w["index"] as int);
                          setState(() {
                            isWater = w["index"] as int;
                          });

                          developer.log(w["index"].toString());
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
                                        '${w["imgName"]}',
                                        height: 60,
                                      ),
                                      Text(
                                        '${w["title"]}',
                                        style: TextStyle(
                                            color:
                                                (isWater == w["index"] as int)
                                                    ? Colors.white
                                                    : Colors.black,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )),
                                  decoration: (isWater == w["index"] as int)
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
