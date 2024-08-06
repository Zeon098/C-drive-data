import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Login Page',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
        ),
        body: Center(
          child: FloatingActionButton.extended(
            onPressed: GoogleSignIn().signIn,
            icon: Image.asset('images/google.jpeg', height: 32, width: 32),
            label: const Text('Sign in with Google'),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
        ));
  }
}
