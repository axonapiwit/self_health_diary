import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<String?> signUpWithEmail(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      e.code == 'weak-password'
          ? print('The password provided is too weak.')
          : e.code == 'email-already-in-use'
              ? print('The account already exists for that email.')
              : print(e.message);
    }
  }

  Future<String?> signInWithEmail(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> signOutWithEmail() async {
    await _firebaseAuth.signOut();
  }

  Future signInWithGoogle() async {
    try {
      final googleUser =
          // ignore: invalid_return_type_for_catch_error
          await googleSignIn.signIn().catchError((onError) => print(onError));

      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final authResult = await _firebaseAuth.signInWithCredential(credential);
      if (authResult.additionalUserInfo!.isNewUser) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({
          'uid': authResult.user!.uid,
          'role': 'new',
          'fname': authResult.user!.displayName,
          
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOutWithGoogle() async {
    await googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
