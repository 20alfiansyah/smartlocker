// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartlocker/screens/login_page.dart';
import 'package:smartlocker/screens/main_page.dart';

class AuthRoute extends StatelessWidget {
  const AuthRoute({super.key});
  static String id = 'main_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if (snapshot.hasData) {
            return const MainPage();
          }
          else{
            return const LoginPage();
          }
        },
      ),
    );
  }
}