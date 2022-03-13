import 'package:flutter/material.dart';
import 'package:self_health_diary/screens/navbar.dart';
import 'package:self_health_diary/screens/signUp_and_signIn.dart';
import 'package:self_health_diary/screens/validation.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      return FutureBuilder<DocumentSnapshot>(
        future: users.doc(firebaseUser.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow)),
            );
          }
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          if (data['role'] == 'new') return ValidationScreen();
          return NavBar();
        },
      );
    }

    return SignUpScreen();
  }
}

// fetchUser(String uid) async {
//     final userDoc =
//         await FirebaseFirestore.instance.collection('users').doc(uid).get();
//     if (userDoc.data()!['role'] == 'new') {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ValidationScreen(),
//         ),
//       );
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance?.addPostFrameCallback((_) {
//       final user = Provider.of<User?>(context, listen: false);
//       if (user == null) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => SignUpScreen(),
//           ),
//         );
//       } else {
//         fetchUser(user.uid);
//       }
//     });
//   }