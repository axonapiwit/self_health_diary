import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:self_health_diary/themes/colors.dart';

class ExerciseList extends StatefulWidget {
  const ExerciseList({Key? key}) : super(key: key);

  @override
  _ExerciseListState createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  var exercise = [
    {
      'imgName': 'assets/icons/dumbbell.png',
      'title': '60 Min',
      'index': 0,
    },
    {
      'imgName': 'assets/icons/shoes.png',
      'title': '30 Min',
      'index': 1,
    },
    {
      'imgName': 'assets/icons/sneakers.png',
      'title': '15 Min',
      'index': 2,
    },
    {
      'imgName': 'assets/icons/obesity.png',
      'title': "No Exercise",
      'index': 3,
    },
  ];

  int? isExercise = null;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Exercise',
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
              children: exercise
                  .map<Widget>((m) => GestureDetector(
                        onTap: () {
                          setState(() {
                            isExercise = m["index"] as int;
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
                                            color:
                                                (isExercise == m["index"] as int)
                                                    ? Colors.white
                                                    : Colors.black,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )),
                                  decoration: (isExercise == m["index"] as int)
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
