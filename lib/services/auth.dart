import 'package:brew_crew/models/userr.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Userr? _userFromFirebaseUser(User? user) {
    return user != null ? Userr(uid: user.uid) : null;
  }

  Stream<Userr?> get user {
    // return _auth.authStateChanges().map(
    //   (User? user) => _userFromFirebaseUser(user));
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // Sign in Anonymous
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// Sign in with Email and Password

// Register with Email and Password

// Sign Out
Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
}

}
