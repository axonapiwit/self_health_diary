import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:self_health_diary/models/diary.dart';
import 'package:self_health_diary/screens/home.dart';
import 'package:self_health_diary/widgets/exercise_list.dart';
import 'package:self_health_diary/widgets/foods_list.dart';
import 'package:self_health_diary/widgets/moods_list.dart';
import 'package:self_health_diary/widgets/notepad.dart';
import 'package:self_health_diary/widgets/sleeps_list.dart';
import 'package:self_health_diary/widgets/waters_list.dart';
import 'package:self_health_diary/themes/colors.dart';

class DetailDiary extends StatefulWidget {
  const DetailDiary({Key? key}) : super(key: key);

  @override
  _DetailDiaryState createState() => _DetailDiaryState();
}

class _DetailDiaryState extends State<DetailDiary> {
  Diary diary = Diary(dateTime: DateTime.now());

  @override
  initState() {
    getDiary();
    super.initState();
  }

  getDiary() async {
    final res = await FirebaseFirestore.instance.collection('diaries').doc().get();
    
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    Future editDiary() async {
      await FirebaseFirestore.instance
          .collection('diaries')
          .doc(user!.uid)
          .update({
        'mood': diary.mood,
        'sleep': diary.sleep,
        'food': diary.food,
        'water': diary.water,
        'exercise': diary.exercise,
        'dateTime': diary.dateTime,
        // 'status': true,
        'moodPoint': diary.moodPoint,
      }).then((value) => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              ));
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
                        editDiary();
                        setState(() {
                          diary.dateTime;
                        });
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
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
