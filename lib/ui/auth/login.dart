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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 48.0, bottom: 48.0),
                  child: Image.asset('assets/images/logo.png'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder()
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder()
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(60.0),
                      shadowColor: Colors.black,
                      elevation: 12.0
                    ),
                    onPressed: () => {},
                    child: Text('Sign in')
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 48.0, bottom: 12.0),
                  child: Text('- Or sign in with -'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 60.0,
                        width: 100.0,
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0,1),
                              blurRadius: 3.0,
                              color: Colors.black.withOpacity(0.3)
                            )
                          ] 
                        ),
                        child: Image.asset(
                          'assets/images/social/google.png',
                          scale: 18.0,
                        ),
                      ),
                      Container(
                        height: 60.0,
                        width: 100.0,
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0,1),
                              blurRadius: 3.0,
                              color: Colors.black.withOpacity(0.3)
                            )
                          ] 
                        ),
                        child: Image.asset(
                          'assets/images/social/facebook.png',
                          scale: 18.0,
                        ),
                      ),
                      Container(
                        height: 60.0,
                        width: 100.0,
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0,1),
                              blurRadius: 3.0,
                              color: Colors.black.withOpacity(0.3)
                            )
                          ] 
                        ),
                        child: Image.asset(
                          'assets/images/social/twitter.png',
                          scale: 18.0,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}