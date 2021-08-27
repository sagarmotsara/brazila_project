import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todoproject_brazila/UI_homepage+task/Home_Screen.dart';
import 'package:todoproject_brazila/UI_of_email_registration/Login%20Screen.dart';


//Future (async , await,then())
//Stream- Based on Reactive Programming (Real Time)

FirebaseAuth _auth = FirebaseAuth.instance;

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        // if(snapshot.hasData){
        //   final user = snapshot.data;
        //   if(user == null){
        //     return SingInScreen();
        //   }
        //   return HomeScreen();
        // }
        //
        // return Scaffold(
        //   body: Center(
        //     child: CircularProgressIndicator(),
        //   ),
        // );

        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return EmailSignInScreen(auth: _auth);
          }
           
          return HomePage(auth: _auth);
      
         
          
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
