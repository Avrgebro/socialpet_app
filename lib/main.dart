import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialpet/config/constants/app_constants.dart';
import 'package:socialpet/core/auth/authentication/bloc/authentication_bloc.dart';
import 'package:socialpet/data/repositories/auth_repository.dart';
import 'package:socialpet/ui/auth/login.dart';
import 'package:socialpet/ui/auth/register.dart';
import 'package:socialpet/ui/misc/error.dart';
import 'package:socialpet/ui/home.dart';
import 'package:socialpet/ui/misc/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 
  runApp(BlocProvider(
      create: (context) {
        return AuthenticationBloc(authRepository: AuthRepository())
          ..add(AppLoaded());
      },
      child: App(),
    )
  );
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: AppConstants.appName,
        theme: ThemeData(
          //primarySwatch: Color(0xff0072BB),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Color(0xFF0072BB),
            secondary: Color(0xFFE18335)
          )
        ),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                  if (state is Uninitialized) {
                    return SplashScreen();
                  } else if (state is Authenticated) {
                    return HomePage(user: state.user);
                  } else if (state is Unregistered) {
                    return RegisterPage(uuid: state.uuid);
                  } else if (state is Failure) {
                    return ErrorPage(error: state.message);
                  } else if (state is Unauthenticated) {
                    return LoginPage();
                  } else {
                    return ErrorPage(error: 'Unhandled error');
                  }
                }),
              );
  }
}
