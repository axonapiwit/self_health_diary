import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/src/provider.dart';
import 'package:self_health_diary/models/profile.dart';
import 'package:self_health_diary/screens/navbar.dart';
import 'package:self_health_diary/services/authentication_service.dart';
import 'package:self_health_diary/widgets/icon_text_input.dart';

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
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();

    Future addUser() async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({
        'role': role,
        // 'tag': Random().nextInt(9999).toString(),
        // 'fname': firstNameController.text,
        // 'lname': lastNameController.text,
        'fname': validateUser.fname,
        'lname': validateUser.lname,
        // 'img': urlDownload,
      }).then((value) => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NavBar()),
              ));
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.grey[850],
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
                                color: Colors.white,
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
                                'Create Account',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'PLease fill the input blow here.',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                              SizedBox(height: 30),
                              IconTextInput(
                                  controller: firstNameController,
                                  hint: 'First Name',
                                  icon: 'person',
                                  obscureText: false),
                              SizedBox(height: 10),
                              IconTextInput(
                                  controller: lastNameController,
                                  hint: 'Last Name',
                                  icon: 'person',
                                  obscureText: false),
                              SizedBox(height: 30),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                margin: EdgeInsets.symmetric(vertical: 20),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(
                                    color: Colors.pink.shade300,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(29))),
                                child: TextField(
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.rtt_rounded,
                                          color: Colors.white),
                                      hintText: "Your First Name",
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: InputBorder.none),
                                  onSubmitted: (String fname) {
                                    validateUser.fname = fname;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                            child: Text('Submit'),
                            onPressed: () {
                              addUser();
                            }),
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
      ),
    );

    //   return Scaffold(
    //     body: SingleChildScrollView(
    //       child: SafeArea(
    //         child: Container(
    //           color: Colors.pink.shade50,
    //           height: MediaQuery.of(context).size.height,
    //           child: Form(
    //             key: formKey,
    //             child: Center(
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Container(
    //                     child: Image.asset(
    //                       'assets/images/diary.png',
    //                       height: 150,
    //                       fit: BoxFit.cover,
    //                     ),
    //                   ),
    //                   SizedBox(height: 20),
    //                   Container(
    //                     width: MediaQuery.of(context).size.width * 0.8,
    //                     margin: EdgeInsets.symmetric(vertical: 20),
    //                     padding:
    //                         EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    //                     decoration: BoxDecoration(
    //                         color: Colors.pink.shade300,
    //                         borderRadius: BorderRadius.all(Radius.circular(29))),
    //                     child: TextFormField(
    //                       decoration: InputDecoration(
    //                           icon: Icon(Icons.rtt_rounded, color: Colors.white),
    //                           hintText: "Your First Name",
    //                           hintStyle: TextStyle(color: Colors.white),
    //                           border: InputBorder.none),
    //                     ),
    //                   ),
    //                   Container(
    //                     width: MediaQuery.of(context).size.width * 0.8,
    //                     margin: EdgeInsets.symmetric(vertical: 20),
    //                     padding:
    //                         EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    //                     decoration: BoxDecoration(
    //                         color: Colors.pink.shade300,
    //                         borderRadius: BorderRadius.all(Radius.circular(29))),
    //                     child: TextFormField(
    //                       decoration: InputDecoration(
    //                           icon: Icon(Icons.rtt_rounded, color: Colors.white),
    //                           hintText: "Your Last Name",
    //                           hintStyle: TextStyle(color: Colors.white),
    //                           border: InputBorder.none),
    //                     ),
    //                   ),
    //                   ElevatedButton(
    //                       child: Text(
    //                         'Submit',
    //                         style: TextStyle(
    //                             fontSize: 20, fontWeight: FontWeight.bold),
    //                       ),
    //                       style: ElevatedButton.styleFrom(
    //                           shape: StadiumBorder(),
    //                           padding: EdgeInsets.symmetric(
    //                               vertical: 15, horizontal: 40),
    //                           primary: Colors.black),
    //                       // onPressed: addUser,
    //                       onPressed: () async {
    //                         if (formKey.currentState!.validate()) {
    //                           formKey.currentState!.save();
    //                           await addUser();
    //                           Navigator.pushReplacement(context,
    //                               MaterialPageRoute(builder: (context) {
    //                             return NavBar();
    //                           }));
    //                         }
    //                         formKey.currentState!.reset();
    //                       })
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
  }
}
