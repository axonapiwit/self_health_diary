import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:self_health_diary/themes/colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:self_health_diary/widgets/edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  late List _data;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Palette.tertiary,
            appBar: AppBar(
                backgroundColor: Palette.tertiary,
                elevation: 0,
                title: const Text(
                  'โปรไฟล์',
                  style: TextStyle(
                      color: Palette.primary,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.ellipsisV,
                      color: Colors.black,
                    ),
                    tooltip: 'Show Snackbar',
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 150,
                            color: Palette.secondary,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  TextButton(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          FaIcon(FontAwesomeIcons.pen,
                                              color: Palette.secondary[300]),
                                          SizedBox(width: 10),
                                          Text(
                                            'แก้ไขโปรไฟล์',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 24),
                                          ),
                                        ],
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EditProfile(
                                                    fname: _data[0]['fname'],
                                                    lname: _data[0]['lname'],
                                                    gender: _data[0]['gender'],
                                                    weight: (_data[0]['weight']).toString()
                                                  )),
                                        );
                                      }),
                                  TextButton(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        FaIcon(FontAwesomeIcons.timesCircle,
                                            color: Colors.red),
                                        SizedBox(width: 10),
                                        Text(
                                          'ปิด',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 24),
                                        ),
                                      ],
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ]),
            body: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('uid', isEqualTo: user!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Palette.primary)),
                    );
                  }
                  List data =
                      snapshot.data!.docs.map((doc) => doc.data()).toList();

                  _data = data;

                  // BMI
                  String _message = '';

                  final double? height = data[0]['height']! / 100;
                  final double? weight = data[0]['weight'];

                  double _bmi;

                  _bmi = double.parse(
                      (weight! / (height! * height))
                          .toStringAsFixed(2));
                  if (_bmi < 18.5) {
                    _message = "น้ำหนักน้อยกว่ามาตรฐาน";
                  } else if ((_bmi > 18.4) && (_bmi < 23)) {
                    _message = 'ปกติ';
                  } else if ((_bmi > 22.9) && (_bmi < 25)) {
                    _message = 'อ้วนระดับ 1';
                  } else if ((_bmi > 24.9) && (_bmi < 30)) {
                    _message = 'อ้วนระดับ 2';
                  } else {
                    _message = 'อ้วนระดับ 3';
                  }

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
                                color:
                                    Colors.blueAccent.shade100.withOpacity(0.5),
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
                            bottom: 50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    data[0]['fname'] + ' ' + data[0]['lname'],
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Palette.primary),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'ส่วนสูง:' +
                                        ' ' +
                                        data[0]['height'].toString() +
                                        ' ' +
                                        'น้ำหนัก:' +
                                        ' ' +
                                        data[0]['weight'].toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Palette.primary),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                        'เพศ:' + ' ' + data[0]['gender'],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Palette.primary),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                        'ดัชนีมวลกาย: ' + _bmi.toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Palette.primary),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    _message,
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
                })));
  }
}
