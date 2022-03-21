import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/src/provider.dart';
import 'package:self_health_diary/models/profile.dart';
import 'package:self_health_diary/screens/navbar.dart';
import 'package:self_health_diary/services/authentication_service.dart';
import 'package:self_health_diary/services/radio.dart';
import 'package:self_health_diary/themes/colors.dart';

import 'package:self_health_diary/widgets/textfield_input.dart';

class ValidationScreen extends StatefulWidget {
  const ValidationScreen({Key? key}) : super(key: key);

  @override
  _ValidationScreenState createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  Profile validateUser = Profile();
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  bool _validateFname = false;
  bool _validateLname = false;
  bool _validateWeight = false;
  bool _validateHeight = false;

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String role = 'user';

    Future addUser() async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({
        'role': role,
        'fname': validateUser.fname,
        'lname': validateUser.lname,
        'height': validateUser.height,
        'weight': validateUser.weight,
        'gender': validateUser.gender,
      }).then((value) => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NavBar()),
              ));
    }

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Palette.tertiary,
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Palette.tertiary,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 40, left: 20),
                            child: TextButton(
                              onPressed: () {
                                context
                                    .read<AuthenticationService>()
                                    .signOutWithGoogle();
                              },
                              style: ButtonStyle(
                                splashFactory: NoSplash.splashFactory,
                              ),
                              child: Icon(
                                Icons.keyboard_backspace,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ยืนยันบัญชีผู้ใช้',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'กรุณากรอกข้อมูลให้ครบถ้วน',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                              TextfieldInput(
                                width: MediaQuery.of(context).size.width * 0.8,
                                labelText: 'ชื่อ',
                                validate:
                                    _validateFname ? 'กรุณากรอกชื่อ' : null,
                                controller: _fnameController,
                                onChanged: (String fname) {
                                  validateUser.fname = fname;
                                },
                              ),
                              TextfieldInput(
                                width: MediaQuery.of(context).size.width * 0.8,
                                labelText: 'นามสกุล',
                                validate:
                                    _validateLname ? 'กรุณากรอกนามสกุล' : null,
                                controller: _lnameController,
                                onChanged: (String lname) {
                                  validateUser.lname = lname;
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextfieldInput(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    labelText: 'ส่วนสูง',
                                    validate: _validateHeight
                                        ? 'กรุณากรอกส่วนสูง'
                                        : null,
                                    controller: _heightController,
                                    suffix: Container(
                                      decoration: BoxDecoration(
                                        color: Palette.primary,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      padding: EdgeInsets.all(2),
                                      child: Text(
                                        'เซนติเมตร',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    onChanged: (String height) {
                                      validateUser.height = height.length != 0
                                          ? height != '0'
                                              ? double.parse(height)
                                              : 0.0
                                          : 0.0;
                                    },
                                  ),
                                  TextfieldInput(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    labelText: 'น้ำหนัก',
                                    validate: _validateWeight
                                        ? 'กรุณากรอกน้ำหนัก'
                                        : null,
                                    controller: _weightController,
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
                                    onChanged: (String weight) {
                                      validateUser.weight = weight.length != 0
                                          ? weight != '0'
                                              ? double.parse(weight)
                                              : 0.0
                                          : 0.0;
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'เพศกำเนิด',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              RadioGroup(
                                options: [
                                  RadioOption(label: 'ชาย', value: 'ชาย'),
                                  RadioOption(label: 'หญิง', value: 'หญิง'),
                                ],
                                onChange: (value) {
                                  setState(() {
                                    validateUser.gender = value;
                                  });
                                },
                                // selected: 0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Stack(
          alignment: FractionalOffset(.5, 1.0),
          children: [
            InkWell(
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Palette.primary,
                ),
                child: Center(
                  child: Text(
                    'บันทึก',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onTap: () {
                setState(() {
                  bool isPass = true;
                  if (_fnameController.text.isEmpty) {
                    isPass = false;
                    _validateFname = true;
                  }
                  if (_lnameController.text.isEmpty) {
                    isPass = false;
                    _validateLname = true;
                  }
                  if (_heightController.text.isEmpty) {
                    isPass = false;
                    _validateHeight = true;
                  }
                  if (_weightController.text.isEmpty) {
                    isPass = false;
                    _validateWeight = true;
                  }
                  if (isPass) {
                    addUser();
                  }
                });
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //   content: Text("Sending Message"),
                // ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
