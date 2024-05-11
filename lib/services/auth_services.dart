// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../models/User.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void>addUserDetails(String email, String password, String username) async{
    var uuid = const Uuid();
    final User firebaseUser = _auth.currentUser!;
    Map<String, dynamic> userDetails = {
      'id' : uuid.v1(),
      'email': email,
      'password': password,
      'username': username,
      'order': []
    };
    await FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).set(userDetails);
  }

  Future<UserModel?>signUpUser(
    String email,
    String password,
    String username
  )async{
    try {
      print(password);
      final UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
      addUserDetails(email, password, username);
      final User? firebaseUser = credential.user;
      if (firebaseUser != null) {
        return UserModel(
          id: firebaseUser.uid,
          email: firebaseUser.email,
          username: username,
          password: password
        );
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<void>signOutUser() async{
    final User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser!= null) {
      await FirebaseAuth.instance.signOut();
    }
  }

  Future<UserModel?>signInUser(
    String email,
    String password
  )async{
    try {
      final UserCredential credential = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
      final User? firebaseUser = credential.user;
      if (firebaseUser!= null) {
        return UserModel(
          id: firebaseUser.uid,
          email: firebaseUser.email,
          username: firebaseUser.displayName,
          password: password
        );
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
    return null;
  }
}

