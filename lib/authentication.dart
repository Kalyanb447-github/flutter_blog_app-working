import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthImplementation {
Future<String> SignUp(String email, String password); 
 Future<String> SignIn(String email, String password);
  Future<void> getCurrentUser();
    Future<void> SignOut();
}

class Auth implements AuthImplementation {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String> SignIn(String email, String password) async {
    AuthResult user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.toString();
  }

    Future<String> SignUp(String email, String password) async {
    AuthResult user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user.additionalUserInfo.providerId;

      //  try {
      //             FirebaseUser user =await _firebaseAuth.createUserWithEmailAndPassword(  email: email, password: password);
      //      return user.uid;
      //  } catch (e) {
      //  }

  
  }
    Future<void> getCurrentUser() async {
      FirebaseUser user =await _firebaseAuth.currentUser();

      return user.uid;
 
  }
   
    Future<void> SignOut() async {
      _firebaseAuth.signOut();
 
  }


}
