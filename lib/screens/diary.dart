import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:self_health_diary/models/diary.dart';
import 'package:self_health_diary/widgets/exercise_list.dart';
import 'package:self_health_diary/widgets/foods_list.dart';
import 'package:self_health_diary/widgets/moods_list.dart';
import 'package:self_health_diary/widgets/notepad.dart';
import 'package:self_health_diary/widgets/sleeps_list.dart';
import 'package:self_health_diary/widgets/waters_list.dart';
import 'package:self_health_diary/themes/colors.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({Key? key}) : super(key: key);

  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  Diary diary = Diary(dateTime: DateTime.now());

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    Future addDiary() async {
      print('object');
      // await FirebaseFirestore.instance
      //     .collection('diaries')
      //     .where('dateTime',
      //         isLessThan: new DateTime.now().subtract(Duration(days: 1)))
      //     .get()
      //     .then((value) => {print(value.docs.length)});
      await FirebaseFirestore.instance
          .collection('diaries')
          .orderBy('dateTime')
          .get()
          .then((value) => {
                print(value.docs.last.data()['dateTime'].toDate()),
                print(new DateTime.now().subtract(Duration(days: 1))),
                if (value.docs.last
                    .data()['dateTime']
                    .toDate()
                    .isBefore(new DateTime.now().subtract(Duration(days: 1))))
                  {
                    print('yes'),
                    FirebaseFirestore.instance.collection('diaries').add({
                      'createdBy': user!.uid,
                      'mood': diary.mood,
                      'sleep': diary.sleep,
                      'food': diary.food,
                      'water': diary.water,
                      'exercise': diary.exercise,
                      'dateTime': diary.dateTime,
                      'status': true,
                      'moodPoint': diary.moodPoint,
                    }).then((value) => FirebaseFirestore.instance
                            .collection('diaries')
                            .doc(value.id)
                            .update({
                          'id': value.id,
                        }).then((value) => Navigator.pop(context)))
                  }
                else
                  print('no')
              });
    }

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Palette.tertiary,
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  MoodsList(onChange: (title, index) {
                    setState(() {
                      diary.mood = title;
                      diary.moodPoint = index;
                    });
                    print(title);
                    print(index);
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  SleepsList(onChange: (title, index) {
                    setState(() {
                      diary.sleep = title;
                    });
                    print(title);
                    print(index);
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  FoodsList(onChange: (title, index) {
                    setState(() {
                      diary.food = title;
                    });
                    print(title);
                    print(index);
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  WatersList(onChange: (title, index) {
                    setState(() {
                      diary.water = title;
                    });
                    print(title);
                    print(index);
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  ExerciseList(onChange: (title, index) {
                    setState(() {
                      diary.exercise = title;
                    });
                    print(title);
                    print(index);
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  NotePad(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Palette.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      child: Text(
                        'Save',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          diary.dateTime;
                        });
                        addDiary();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
