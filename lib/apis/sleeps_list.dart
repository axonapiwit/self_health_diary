import 'package:flutter/material.dart';
import 'package:self_health_diary/themes/colors.dart';

class SleepsList extends StatefulWidget {
  const SleepsList({Key? key, required this.onChange, this.sleepSelected = ''})
      : super(key: key);

  final void Function(String, int) onChange;
  final String sleepSelected;

  @override
  _SleepsListState createState() => _SleepsListState();
}

class _SleepsListState extends State<SleepsList> {
  var sleeps = [
    {
      'imgName': 'assets/icons/sleep.png',
      'title': '8 ชม. ขึ้นไป',
      'index': 0,
    },
    {
      'imgName': 'assets/icons/sleep3.png',
      'title': '7-8 ชม.',
      'index': 1,
    },
    {
      'imgName': 'assets/icons/sleep2.png',
      'title': '5-6 ชม.',
      'index': 2,
    },
    {
      'imgName': 'assets/icons/sleep4.png',
      'title': '3-4 ชม.',
      'index': 3,
    },
    {
      'imgName': 'assets/icons/tired.png',
      'title': "ไม่ได้นอน",
      'index': 4,
    },
  ];

  @override
  initState() {
    getSleep();
    super.initState();
  }

  getSleep() {
    for (var i = 0; i < sleeps.length; i++) {
      if (widget.sleepSelected == sleeps[i]['title']) {
        isSleep = sleeps[i]['index'] as int;
      }
    }
  }

  int? isSleep = null;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'การพักผ่อน',
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
                                        overflow: TextOverflow.ellipsis,
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
