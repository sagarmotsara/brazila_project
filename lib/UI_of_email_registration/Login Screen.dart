import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:todoproject_brazila/UI_of_email_registration/registration_screen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class EmailSignInScreen extends StatefulWidget {
  const EmailSignInScreen({Key? key,  required this.auth}) : super(key: key);
  final FirebaseAuth auth;
  @override
  _EmailSignInScreenState createState() => _EmailSignInScreenState();
}

class _EmailSignInScreenState extends State<EmailSignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() { 
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _signInWithEmailAndPassword() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final String email = _emailController.text;
      final String password = _passwordController.text;

      await _auth.signInWithEmailAndPassword(email: email, password: password);
     
    } catch (e) {
      print(e.toString());
      final snackBar = SnackBar(content: Text("Email or Password is incorrect"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String? emailValidator(String? value) {
    String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return 'Please Enter valid Email';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sing In Screen"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "Sing in with email and password",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: emailValidator,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "password",
                ),
                obscureText: true,
                validator: (String? value) {
                  if (value != null && value.isEmpty)
                    return "Please Enter Password";
                },
              ),
              SizedBox(height: 20),
              _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                           _signInWithEmailAndPassword();
                         
                        }
                      },
                      child: Text("Sign In"),
                    ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          RegistrationScreen(auth: widget.auth),
                    ),
                  );
                },
                child: Text("Don't have account ? Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
