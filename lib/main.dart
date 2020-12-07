import 'file:///C:/Users/przeo/AndroidStudioProjects/bloc_flutter_time_tracker/lib/app/landing_page.dart';
import 'package:bloc_flutter_time_tracker/app/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Tracker',
      theme: ThemeData(
        primarySwatch: Colors.indigo, // define primary color of entire app
      ),
      home: LandingPage(
        auth: Auth(),
      ),
    );
  }
}
