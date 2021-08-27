
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:todoproject_brazila/UI_of_email_registration/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MyNotes",
      home: SplashScreen(),
    );
  }
}
