import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  String? _uuid;
  RegisterPage({Key? key, String? uuid})
  : _uuid = uuid,
    super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
           child: Text('register: ' + (widget._uuid ?? '') ),
        ),
      ),
    );
  }
}