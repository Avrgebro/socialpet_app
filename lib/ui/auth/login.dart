import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Email'
                ),
              ),
              
              TextField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  hintText: 'Password'
                ),
              ),
              ElevatedButton(
                onPressed: () => {},
                child: Text('Log in')
              )
            ],
          ),
        ),
      ),
    );
  }
}