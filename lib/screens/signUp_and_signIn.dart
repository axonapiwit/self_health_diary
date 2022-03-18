import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:self_health_diary/services/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:self_health_diary/themes/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(height: 50),
                    Container(
                      child: Text(
                        "แอปพลิเคชั่นไดอารี่สุขภาพ",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                      child: Text(
                        "เพื่อการพัฒนาการดูแลตนเองในวัยผู้ใหญ่",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Positioned(
                bottom: MediaQuery.of(context).size.height * 0.35,
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/images/WomanBreakdown.png',
                      height: MediaQuery.of(context).size.height * 0.5),
                )),
            Positioned(
              top: 450,
              right: 0,
              left: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "สมัครและเข้าสู่ระบบ",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      child: Container(
                        height: 60,
                        width: 400,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.9)),
                            color: Colors.red,
                            boxShadow: [
                              BoxShadow(color: Colors.white, spreadRadius: 2)
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              FontAwesomeIcons.google,
                              size: 30,
                              color: Colors.white,
                            ),
                            Text(
                              'เข้าสู่ระบบด้วยกูเกิล',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        context
                            .read<AuthenticationService>()
                            .signInWithGoogle();
                      },
                    ),
                    SizedBox(height: 40),
                    InkWell(
                      child: Container(
                        height: 60,
                        width: 400,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.9)),
                            color: Palette.tertiary[100],
                            boxShadow: [
                              BoxShadow(color: Colors.white, spreadRadius: 2)
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              FontAwesomeIcons.solidEnvelope,
                              size: 30,
                              color: Colors.white,
                            ),
                            Text(
                              'เข้าสู่ระบบด้วยอีเมลล์',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
