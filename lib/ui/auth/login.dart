import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialpet/core/auth/login/bloc/login_bloc.dart';
import 'package:socialpet/data/repositories/auth_repository.dart';
import 'package:socialpet/utils/helpers/user_credentials_helper.dart';
import 'package:socialpet/utils/mixins/input_validation_mixin.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with InputValidationMixin {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => LoginBloc(authRepository: AuthRepository()),
        child: SafeArea(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 56.0),
                      child: Image.asset('assets/images/logo.png'),
                    ),
                    BlocListener<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if(state is LoginFailed){
                          Flushbar(
                            title:  "Oops! we could not log you in",
                            message:  "Please make sure you've entered correct credentials",
                            duration:  Duration(seconds: 3),
                            margin: EdgeInsets.all(8),
                            borderRadius: BorderRadius.circular(8),
                            flushbarPosition: FlushbarPosition.TOP,
                            icon: Icon(
                              Icons.info_outline,
                              size: 28.0,
                              color: Colors.white,
                            ),
                            backgroundColor: Colors.red[500]!,

                          )..show(context);
                        } else if(state is LoginSucceded){
                          Flushbar(
                            title:  "Welcome Back!",
                            message:  "You've successfully logged in",
                            duration:  Duration(seconds: 3),
                            margin: EdgeInsets.all(8),
                            borderRadius: BorderRadius.circular(8),
                            flushbarPosition: FlushbarPosition.TOP,
                            icon: Icon(
                              Icons.check_circle_outline_rounded,
                              size: 28.0,
                              color: Colors.white,
                            ),
                            backgroundColor: Colors.green[500]!,

                          )..show(context);
                        }
                      },
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  border: OutlineInputBorder()
                                ),
                                validator: (email) => isEmailValid(email!) ? null : 'Enter a valid email',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  border: OutlineInputBorder()
                                ),
                                validator: (password) =>  isPasswordValid(password!)! ? null : 'Enter a valid password',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: BlocBuilder<LoginBloc, LoginState>(
                                builder: (context, state) {
                    
                                  return state is LoginAttempted
                                  ? CircularProgressIndicator()
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size.fromHeight(60.0),
                                        shadowColor: Colors.black,
                                        elevation: 12.0
                                      ),
                                      onPressed: () => {
                                        if(_formKey.currentState!.validate()){
                                          context.read<LoginBloc>().add(LoginWithCredentialsSelected(credentials: UserCredentials(email: emailController.text, password: passwordController.text)))
                                        }
                                      },
                                      child: Text('Sign in')
                                    );
                                }
                              ),
                            ),
                          ],
                        ),
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
                          ElevatedButton(
                            onPressed: () => {},
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              minimumSize: Size(100.0, 60.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                              )
                            ),
                            child: Image.asset(
                              'assets/images/social/google.png',
                              scale: 18.0
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => {},
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              minimumSize: Size(100.0, 60.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                              )
                            ),
                            child: Image.asset(
                              'assets/images/social/facebook.png',
                              scale: 18.0
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => {},
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              minimumSize: Size(100.0, 60.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                              )
                            ),
                            child: Image.asset(
                              'assets/images/social/twitter.png',
                              scale: 18.0
                            ),
                          ),
                          
                          
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text('Not registered yet? click here'),
                        ),
                      ) 
                    )
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}