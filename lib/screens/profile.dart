import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:self_health_diary/themes/colors.dart';
import 'package:dotted_border/dotted_border.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final auth = FirebaseAuth.instance;
  CollectionReference user = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Palette.tertiary,
            body: FutureBuilder<DocumentSnapshot>(
                future: user.doc(auth.currentUser!.uid).get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Palette.primary)),
                    );
                  } else {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    return Scaffold(
                      backgroundColor: Palette.tertiary,
                      body: Container(
                        child: Stack(
                          children: [
                            // Paint Dotted
                            Positioned(
                              top: 280,
                              left: -350,
                              right: 0,
                              child: Container(
                                width: 15.0,
                                height: 15.0,
                                decoration: new BoxDecoration(
                                  color: Colors.red.shade200,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 110,
                              left: -330,
                              right: 0,
                              child: Container(
                                width: 12.0,
                                height: 12.0,
                                decoration: new BoxDecoration(
                                  color: Colors.blue.shade200,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 150,
                              left: 250,
                              right: 0,
                              bottom: 0,
                              child: Center(
                                child: Container(
                                  width: 14.0,
                                  height: 14.0,
                                  decoration: new BoxDecoration(
                                    color: Palette.primary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              bottom: 600,
                              child: Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'Profile',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Palette.primary),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: -150,
                              left: 0,
                              right: 0,
                              bottom: 0,
                              child: Center(
                                child: DottedBorder(
                                  dashPattern: [8, 4],
                                  strokeWidth: 2,
                                  padding: EdgeInsets.all(20),
                                  borderType: BorderType.RRect,
                                  radius: Radius.circular(200),
                                  color: Colors.blueAccent.shade100
                                      .withOpacity(0.5),
                                  child: Container(
                                    width: 200.0,
                                    height: 200.0,
                                    decoration: new BoxDecoration(
                                      color: Palette.secondary,
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        image: AssetImage(
                                            'assets/icons/pinomyim.jpg'),
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(
                                      '${data['fname']} ${data['lname']}',
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Palette.primary),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(
                                      'Height: ${data['height']} Weight: ${data['weight']}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Palette.primary),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(
                                      'BMI: ${data['bmi']}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Palette.primary),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                })));
  }
}
