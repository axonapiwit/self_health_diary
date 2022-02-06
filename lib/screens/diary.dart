import 'package:flutter/material.dart';
import 'package:self_health_diary/screens/home.dart';
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
  @override
  Widget build(BuildContext context) {
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
                  MoodsList(),
                  SizedBox(
                    height: 20,
                  ),
                  SleepsList(),
                  SizedBox(
                    height: 20,
                  ),
                  FoodsList(),
                  SizedBox(
                    height: 20,
                  ),
                  WatersList(),
                  SizedBox(
                    height: 20,
                  ),
                  ExerciseList(),
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
