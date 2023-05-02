import 'package:facebook_clone/auth/notification.dart';
import 'package:flutter/material.dart';
import 'package:facebook_clone/auth/login.dart';
import 'package:facebook_clone/auth/signup.dart';
import 'package:facebook_clone/auth/notification.dart';
import 'package:facebook_clone/auth/forgotpassword.dart';
import 'package:facebook_clone/auth/homescreen.dart';
import 'package:facebook_clone/auth/navscreen.dart';
import 'package:facebook_clone/auth/profilescreen.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: Login());
  }
}
