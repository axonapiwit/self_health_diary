import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:self_health_diary/models/profile.dart';
import 'package:self_health_diary/themes/colors.dart';
import 'package:self_health_diary/services/radio.dart';
import 'package:self_health_diary/widgets/textfield_input.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    Key? key,
    String,
    required this.fname,
    required this.lname,
    required this.gender,
    required this.weight,
  }) : super(key: key);

  final String fname;
  final String lname;
  final String gender;
  final String weight;

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  User? user = FirebaseAuth.instance.currentUser;
  Profile updateProfile = Profile();
  final fInput = TextEditingController();
  final lInput = TextEditingController();
  final weightInput = TextEditingController();
  bool _validateFname = false;
  bool _validateLname = false;
  bool _validateWeight = false;

  @override
  initState() {
    super.initState();
    fInput.text = widget.fname;
    lInput.text = widget.lname;
    updateProfile.gender = widget.gender;
    weightInput.text = widget.weight;
  }

  @override
  Widget build(BuildContext context) {
    Future editProfile() async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({
        'fname':
            fInput.text == widget.fname ? widget.fname : updateProfile.fname,
        'lname':
            lInput.text == widget.lname ? widget.lname : updateProfile.lname,
        'gender': updateProfile.gender,
        'weight': weightInput.text == widget.weight
            ? double.parse(widget.weight)
            : updateProfile.weight,
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
                  TextfieldInput(
                    width: MediaQuery.of(context).size.width * 0.8,
                    labelText: 'ชื่อ',
                    validate: _validateFname ? 'กรุณากรอกชื่อ' : null,
                    controller: fInput,
                    onChanged: (String fname) {
                      updateProfile.fname = fname;
                    },
                  ),
                  SizedBox(height: 10),
                  TextfieldInput(
                    width: MediaQuery.of(context).size.width * 0.8,
                    labelText: 'นามสกุล',
                    validate: _validateLname ? 'กรุณากรอกนามสกุล' : null,
                    controller: lInput,
                    onChanged: (String lname) {
                      updateProfile.lname = lname;
                    },
                  ),
                  SizedBox(height: 10),
                  RadioGroup(
                    labelText: 'เพศกำเนิด',
                    options: [
                      RadioOption(label: 'ชาย', value: 'ชาย'),
                      RadioOption(label: 'หญิง', value: 'หญิง'),
                    ],
                    selectedValue: updateProfile.gender,
                    onChange: (value) {
                      setState(() {
                        updateProfile.gender = value;
                        print(value);
                      });
                    },
                    // selected: 0,
                  ),
                  SizedBox(height: 10),
                  TextfieldInput(
                    width: MediaQuery.of(context).size.width * 0.8,
                    suffix: Container(
                      decoration: BoxDecoration(
                        color: Palette.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: EdgeInsets.all(2),
                      child: Text(
                        'กิโลกรัม',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    labelText: 'น้ำหนัก',
                    controller: weightInput,
                    validate: _validateWeight ? 'กรุณากรอกน้ำหนัก' : null,
                    onChanged: (String weight) {
                      updateProfile.weight = weight.length != 0
                          ? weight != '0'
                              ? double.parse(weight)
                              : 0.0
                          : 0.0;
                    },
                  ),
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
                          if (fInput.text.isEmpty) {
                            isPass = false;
                            _validateFname = true;
                          }
                          if (lInput.text.isEmpty) {
                            isPass = false;
                            _validateLname = true;
                          }
                          if (weightInput.text.isEmpty) {
                            isPass = false;
                            _validateWeight = true;
                          }
                          if (isPass) {
                            editProfile();
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
