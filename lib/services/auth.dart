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
Future signInWithEmailPwd(String email, String pwd) async {
  try {
    UserCredential result = await _auth.signInWithEmailAndPassword(
      email: email, password: pwd);
    User? user = result.user;
    return _userFromFirebaseUser(user);
  } catch(e) {
    print(e.toString());
    return null;
  }
}

// Register with Email and Password
Future regWithEmailPwd(String email, String pwd) async {
  try {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
      email: email, password: pwd);
    User? user = result.user;
    return _userFromFirebaseUser(user);
  } catch(e) {
    print(e.toString());
    return null;
  }
}

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
