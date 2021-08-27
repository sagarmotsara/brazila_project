import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:todoproject_brazila/UI_of_email_registration/Login%20Screen.dart';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key, required this.auth}) : super(key: key);
  final FirebaseAuth auth;
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _displayNameController = TextEditingController();
  bool _isLoading = false;

  _registerWithEmailAndPassword() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final String email = _emailController.text;
      final String password = _passwordController.text;
      final String displayName = _displayNameController.text;

      final credential = await widget.auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user?.updateDisplayName(displayName);

      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.toString());
      final snackBar = SnackBar(content: Text(e.toString()));
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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration Screen"),
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
                  "Register with email and password",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _displayNameController,
                decoration: InputDecoration(labelText: "DisplayName"),
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
                          _registerWithEmailAndPassword();
                        }
                      },
                      child: Text("Register Me"),
                    ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          EmailSignInScreen(auth: widget.auth),
                    ),
                  );
                },
                child: Text("Have an account ? Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
