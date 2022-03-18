import 'package:flutter/material.dart';
import 'package:self_health_diary/themes/colors.dart';

class ExerciseList extends StatefulWidget {
  const ExerciseList(
      {Key? key, required this.onChange, this.exerciseSelected = ''})
      : super(key: key);

  final void Function(String, int) onChange;
  final String exerciseSelected;

  @override
  _ExerciseListState createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  var exercises = [
    {
      'imgName': 'assets/icons/60min.png',
      'title': '60 นาที',
      'index': 0,
    },
    {
      'imgName': 'assets/icons/30min.png',
      'title': '30 นาที',
      'index': 1,
    },
    {
      'imgName': 'assets/icons/15min.png',
      'title': '15 นาที',
      'index': 2,
    },
    {
      'imgName': 'assets/icons/10min.png',
      'title': '10 นาที',
      'index': 3,
    },
    {
      'imgName': 'assets/icons/obesity.png',
      'title': "ไม่ออกกำลังกาย",
      'index': 4,
    },
  ];

  @override
  initState() {
    getExercise();
    super.initState();
  }

  getExercise() {
    for (var i = 0; i < exercises.length; i++) {
      if (widget.exerciseSelected == exercises[i]['title']) {
        isExercise = exercises[i]['index'] as int;
      }
    }
  }

  int? isExercise = null;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'การออกกำลังกาย',
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
              children: exercises
                  .map<Widget>((e) => GestureDetector(
                        onTap: () {
                          widget.onChange(
                              e["title"] as String, e["index"] as int);
                          setState(() {
                            isExercise = e["index"] as int;
                          });

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
                                        '${e["imgName"]}',
                                        height: 60,
                                      ),
                                      Text(
                                        '${e["title"]}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: (isExercise ==
                                                    e["index"] as int)
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )),
                                  decoration: (isExercise == e["index"] as int)
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
