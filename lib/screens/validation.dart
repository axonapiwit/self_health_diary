import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/src/provider.dart';
import 'package:self_health_diary/models/profile.dart';
import 'package:self_health_diary/screens/navbar.dart';
import 'package:self_health_diary/services/authentication_service.dart';
import 'package:self_health_diary/themes/colors.dart';
import 'package:self_health_diary/widgets/radio.dart';

class ValidationScreen extends StatefulWidget {
  const ValidationScreen({Key? key}) : super(key: key);

  @override
  _ValidationScreenState createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  Profile validateUser = Profile();

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String role = 'user';
    // final TextEditingController firstNameController = TextEditingController();
    // final TextEditingController lastNameController = TextEditingController();

    Future addUser() async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({
        'role': role,
        // 'fname': firstNameController.text,
        // 'lname': lastNameController.text,
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
                              SizedBox(height: 10),
                              // IconTextInput(
                              //     controller: firstNameController,
                              //     hint: 'First Name',
                              //     icon: 'person',
                              //     obscureText: false),
                              // SizedBox(height: 10),
                              // IconTextInput(
                              //     controller: lastNameController,
                              //     hint: 'Last Name',
                              //     icon: 'person',
                              //     obscureText: false),
                              // SizedBox(height: 30),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                margin: EdgeInsets.symmetric(vertical: 20),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(
                                    color: Palette.secondary,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(29))),
                                child: TextField(
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.rtt_rounded,
                                          color: Colors.black),
                                      hintText: "ชื่อ",
                                      hintStyle: TextStyle(color: Colors.black),
                                      border: InputBorder.none),
                                  onChanged: (String fname) {
                                    validateUser.fname = fname;
                                  },
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                margin: EdgeInsets.symmetric(vertical: 20),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(
                                    color: Palette.secondary,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(29))),
                                child: TextField(
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.rtt_rounded,
                                          color: Colors.black),
                                      hintText: "นามสกุล",
                                      hintStyle: TextStyle(color: Colors.black),
                                      border: InputBorder.none),
                                  onChanged: (String lname) {
                                    validateUser.lname = lname;
                                  },
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    margin: EdgeInsets.symmetric(vertical: 20),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Palette.secondary,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(29))),
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.rtt_rounded,
                                              color: Colors.black),
                                          hintText: "ส่วนสูง",
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                          border: InputBorder.none),
                                      onChanged: (String height) {
                                        validateUser.height = double.parse(height);
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    margin: EdgeInsets.symmetric(vertical: 20),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Palette.secondary,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(29))),
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.rtt_rounded,
                                              color: Colors.black),
                                          hintText: "น้ำหนัก",
                                          hintStyle:
                                              TextStyle(color: Colors.black),
                                          border: InputBorder.none),
                                      onChanged: (String weight) {
                                        validateUser.weight = double.parse(weight);
                                      },
                                    ),
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
                  // Container(
                  //   margin: EdgeInsets.only(bottom: 20),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         "Already have a account?",
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //       TextButton(
                  //         onPressed: () {
                  //           Navigator.pop(context);
                  //         },
                  //         style: ButtonStyle(
                  //           splashFactory: NoSplash.splashFactory,
                  //         ),
                  //         child: Text(
                  //           'Sign in',
                  //           style: TextStyle(color: Colors.yellow),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
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
                    color: Colors.blue.shade100,
                    boxShadow: [
                      BoxShadow(color: Colors.white, spreadRadius: 2)
                    ]),
                child: Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.pink.shade300,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onTap: () {
                addUser();
              },
            ),
          ],
        ),
      ),
    );
  }
}
