import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialpet/config/constants/app_constants.dart';
import 'package:socialpet/core/auth/authentication/bloc/authentication_bloc.dart';
import 'package:socialpet/ui/auth/login.dart';
import 'package:socialpet/ui/auth/register.dart';
import 'package:socialpet/ui/error/error.dart';
import 'package:socialpet/ui/home.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if(state is Authenticated) {
            return HomePage(
              user: state.user
            );
          } else if (state is Unregistered) {
            return RegisterPage(
              uuid: state.uuid
            );
          } else if (state is Failure) {
            return ErrorPage(
              error: state.message
            );
          } else {
            return LoginPage();
          }
        }
      )
    );
  }
}