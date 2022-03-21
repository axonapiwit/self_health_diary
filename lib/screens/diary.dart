import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:self_health_diary/models/diary.dart';
import 'package:self_health_diary/services/exercise_list.dart';
import 'package:self_health_diary/services/foods_list.dart';
import 'package:self_health_diary/services/moods_list.dart';
import 'package:self_health_diary/services/notepad.dart';
import 'package:self_health_diary/services/sleeps_list.dart';
import 'package:self_health_diary/services/waters_list.dart';
import 'package:self_health_diary/themes/colors.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({Key? key}) : super(key: key);

  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  Diary diary = Diary(dateTime: DateTime.now());
  final noteControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    Future addDiary() async {
      await FirebaseFirestore.instance
          .collection('diaries')
          .orderBy('dateTime', descending: true)
          .get()
          .then((value) async {
        final id = uuid.v4();
        if (value.docs.isEmpty) {
          await FirebaseFirestore.instance.collection('diaries').doc(id).set({
            'createdBy': user!.uid,
            'id': id,
            'mood': diary.mood,
            'sleep': diary.sleep,
            'food': diary.food,
            'water': diary.water,
            'exercise': diary.exercise,
            'dateTime': diary.dateTime,
            'status': true,
            'moodScore': diary.moodScore,
            'note': noteControl.text,
          });
          Navigator.pop(context);
        } else if (value.docs.length > 0) {
          final date1 = value.docs.first.data()['dateTime'].toDate();
          final date2 = DateTime.now();
          final difference = date2.difference(date1).inDays;

          if (difference >= 0 && (date1.day != date2.day)) {
            FirebaseFirestore.instance.collection('diaries').doc(id).set({
              'createdBy': user!.uid,
              'id': id,
              'mood': diary.mood,
              'sleep': diary.sleep,
              'food': diary.food,
              'water': diary.water,
              'exercise': diary.exercise,
              'dateTime': diary.dateTime,
              'status': true,
              'moodScore': diary.moodScore,
              'note': noteControl.text,
            });
            Navigator.pop(context);
          }
        }
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
                      diary.moodScore = index;
                    });
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  SleepsList(onChange: (title, index) {
                    setState(() {
                      diary.sleep = title;
                    });
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  FoodsList(onChange: (title, index) {
                    setState(() {
                      diary.food = title;
                    });
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  WatersList(onChange: (title, index) {
                    setState(() {
                      diary.water = title;
                    });
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  ExerciseList(onChange: (title, index) {
                    setState(() {
                      diary.exercise = title;
                    });
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  NotePad(controller: noteControl),
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
                        'บันทึก',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          bool isPass = true;
                          if (diary.mood == '') {
                            isPass = false;
                          }
                          if (diary.sleep == '') {
                            isPass = false;
                          }
                          if (diary.food == '') {
                            isPass = false;
                          }
                          if (diary.water == '') {
                            isPass = false;
                          }
                          if (diary.exercise == '') {
                            isPass = false;
                          }
                          if (isPass) {
                            diary.dateTime = DateTime.now();
                            addDiary();
                          }
                        });
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
