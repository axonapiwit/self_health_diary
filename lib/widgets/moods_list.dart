import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:self_health_diary/themes/colors.dart';

class MoodsList extends StatefulWidget {
  const MoodsList({Key? key, required this.onChange, this.moodSelected = ''})
      : super(key: key);

  final void Function(String, int) onChange;
  final String moodSelected;

  @override
  _MoodsListState createState() => _MoodsListState();
}

class _MoodsListState extends State<MoodsList> {
  var moods = [
    {
      'imgName': 'assets/icons/excellence.png',
      'title': 'Excellence',
      'index': 5,
    },
    {
      'imgName': 'assets/icons/good.png',
      'title': 'Good',
      'index': 4,
    },
    {
      'imgName': 'assets/icons/medium.png',
      'title': 'Medium',
      'index': 3,
    },
    {
      'imgName': 'assets/icons/badly.png',
      'title': 'Badly',
      'index': 2,
    },
    {
      'imgName': 'assets/icons/verybad.png',
      'title': 'Very Bad',
      'index': 1,
    },
  ];

  @override
  initState() {
    getMood();
    super.initState();
  }

  getMood() {
    for (var i = 0; i < moods.length; i++) {
      if (widget.moodSelected == moods[i]['title']) {
        isMood = moods[i]['index'] as int;
      }
    }
  }

  int? isMood = null;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How are you today!',
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
              children: moods
                  .map<Widget>((m) => GestureDetector(
                        onTap: () {
                          widget.onChange(
                              m["title"] as String, m["index"] as int);
                          setState(() {
                            isMood = m["index"] as int;
                          });

                          developer.log(m["index"].toString());
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
                                        '${m["imgName"]}',
                                        height: 60,
                                      ),
                                      Text(
                                        '${m["title"]}',
                                        style: TextStyle(
                                            color: (isMood == m["index"] as int)
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )),
                                  decoration: (isMood == m["index"] as int)
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
