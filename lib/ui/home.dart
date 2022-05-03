import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialpet/core/auth/authentication/bloc/authentication_bloc.dart';
import 'package:socialpet/data/models/user.dart';

class HomePage extends StatefulWidget {
  final User user;
  HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
           child: Column(
             children: [
               Text('Welcome ' + widget.user.name),
               ElevatedButton(
                 onPressed: () => {
                   BlocProvider.of<AuthenticationBloc>(context).add(UserLoggedOut())
                 },
                 child: Text('Log Out'))
             ]
            ),
        ),
      ),
    );
  }
}