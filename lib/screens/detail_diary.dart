import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:self_health_diary/models/diary.dart';
import 'package:self_health_diary/apis/exercise_list.dart';
import 'package:self_health_diary/apis/foods_list.dart';
import 'package:self_health_diary/apis/moods_list.dart';
import 'package:self_health_diary/apis/notepad.dart';
import 'package:self_health_diary/apis/sleeps_list.dart';
import 'package:self_health_diary/apis/waters_list.dart';
import 'package:self_health_diary/themes/colors.dart';

class DetailDiary extends StatefulWidget {
  const DetailDiary(
      {Key? key,
      String,
      required this.id,
      required this.mood,
      required this.sleep,
      required this.food,
      required this.water,
      required this.exercise,
      required this.note,
      required this.moodScore})
      : super(key: key);

  final String id;
  final String mood;
  final int moodScore;
  final String sleep;
  final String food;
  final String water;
  final String exercise;
  final String note;

  @override
  _DetailDiaryState createState() => _DetailDiaryState();
}

class _DetailDiaryState extends State<DetailDiary> {
  Diary diary = Diary(dateTime: DateTime.now());
  final noteControl = TextEditingController();

  @override
  initState() {
    super.initState();
    diary.mood = widget.mood;
    diary.moodScore = widget.moodScore;
    diary.sleep = widget.sleep;
    diary.food = widget.food;
    diary.water = widget.water;
    diary.exercise = widget.exercise;
    noteControl.text = widget.note;
  }

  @override
  Widget build(BuildContext context) {
    Future editDiary() async {
      await FirebaseFirestore.instance
          .collection('diaries')
          .doc(widget.id)
          .update({
        'mood': diary.mood,
        'sleep': diary.sleep,
        'food': diary.food,
        'water': diary.water,
        'exercise': diary.exercise,
        'status': true,
        'moodScore': diary.moodScore,
        'note': noteControl.text,
      }).then((value) => {Navigator.pop(context), Navigator.pop(context)});
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
                  MoodsList(
                      onChange: (title, index) {
                        setState(() {
                          diary.mood = title;
                          diary.moodScore = index;
                        });
                      },
                      moodSelected: diary.mood),
                  SizedBox(
                    height: 20,
                  ),
                  SleepsList(
                      onChange: (title, index) {
                        setState(() {
                          diary.sleep = title;
                        });
                      },
                      sleepSelected: diary.sleep),
                  SizedBox(
                    height: 20,
                  ),
                  FoodsList(
                      onChange: (title, index) {
                        setState(() {
                          diary.food = title;
                        });
                      },
                      foodSelected: diary.food),
                  SizedBox(
                    height: 20,
                  ),
                  WatersList(
                      onChange: (title, index) {
                        setState(() {
                          diary.water = title;
                        });
                      },
                      waterSelected: diary.water),
                  SizedBox(
                    height: 20,
                  ),
                  ExerciseList(
                      onChange: (title, index) {
                        setState(
                          () {
                            diary.exercise = title;
                          },
                        );
                      },
                      exerciseSelected: diary.exercise),
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
                        'Save',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () {
                        editDiary();
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
