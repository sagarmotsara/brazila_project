import 'dart:async';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:todoproject_brazila/UI_of_email_registration/landing%20screen.dart';
 
 

class SplashScreen extends StatefulWidget {
  SplashScreen({Key ?key}) : super(key: key);
  
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   @override
  void initState() {
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            PageTransition(
                child: LandingScreen(), type: PageTransitionType.leftToRight)));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.grey[50],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              // Splash screen for notesapp, giving 3 sec timer, we can change it later//
              child: RichText(
                  text: TextSpan(
                      text: 'My',
                      style: TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0),
                      children: <TextSpan>[
                    TextSpan(
                        text: 'Notes',
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0))
                  ])),
            ),
            Padding(padding: EdgeInsets.all(10.0),),
            CircularProgressIndicator(backgroundColor: Colors.yellow,)
          ],
        ),
      
    );
  }
}
