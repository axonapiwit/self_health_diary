import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:self_health_diary/models/diary.dart';
import 'package:self_health_diary/widgets/notepad.dart';
import 'package:self_health_diary/themes/colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    Key? key,
    String,
    required this.uid,
    required this.fname,
    required this.lname,
    required this.gender,
    required this.weight,
    // required this.note,
  }) : super(key: key);

  final String uid;
  final String fname;
  final String lname;
  final int gender;
  final String weight;
  // final String note;

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Diary diary = Diary(dateTime: DateTime.now());
  final fnote = TextEditingController();

  @override
  initState() {
    super.initState();

    fnote.text = widget.fname;
  }

  @override
  Widget build(BuildContext context) {
    Future editProfile() async {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(widget.uid)
          .update({
        // 'moodScore': diary.moodScore,
        'fname': fnote.text,
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
                  NotePad(controller: fnote),
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
                        editProfile();
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
