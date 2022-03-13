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
                SizedBox(height: 100),
                Container(
                  child: Text(
                    "สมัครและเข้าสู่ระบบ",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            Positioned(
                bottom: MediaQuery.of(context).size.height * 0.35,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/images/WomanBreakdown.png',
                      height: MediaQuery.of(context).size.height * 0.5),
                )),
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
                                BorderRadius.all(Radius.circular(40.9)),
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
                              'เข้าสู่ระบบด้วย Google',
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
                                BorderRadius.all(Radius.circular(40.9)),
                            color: Palette.primary,
                            boxShadow: [
                              BoxShadow(color: Colors.white, spreadRadius: 2)
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              FontAwesomeIcons.envelope,
                              size: 30,
                              color: Colors.white,
                            ),
                            Text(
                              'เข้าสู่ระบบด้วย Email',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => RegisterScreen(),
                        //   ),
                        // );
                      },
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
