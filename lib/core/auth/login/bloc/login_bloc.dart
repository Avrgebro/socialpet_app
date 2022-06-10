import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:socialpet/core/auth/authentication/bloc/authentication_bloc.dart';
import 'package:socialpet/data/repositories/auth_repository.dart';
import 'package:socialpet/utils/enums/socials.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socialpet/utils/helpers/user_credentials_helper.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final AuthRepository _authRepository;

  LoginBloc({required AuthRepository authRepository})
    : _authRepository = authRepository, 
      super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginWithSocialSelected) {
      yield* _mapLoginWithSocialsToState(event);
    } else if (event is LoginWithCredentialsSelected) {
      yield* _mapLoginWithCredentialsToState(event);
    }
  }

  Stream<LoginState> _mapLoginWithCredentialsToState(LoginWithCredentialsSelected event) async* {
    yield LoginAttempted();
    
    try {
      final user = await _authRepository.signInWithCredentials(event.credentials);
      if (user != null) {
        final loginResponse = await _authRepository.oAuthLogin(event.credentials);
        if(loginResponse != null) {
          yield LoginSucceded();
        } else {
          yield LoginUnregistered(uuid: user.user!.uid,);
        }
      } else {
        print('Firebase failed');
        throw Exception('Could not retrieve user data from Firebase');
      }
    
    } catch (e) {
      yield LoginFailed(message: e.toString());
    } 


  }

  Stream<LoginState> _mapLoginWithSocialsToState(LoginWithSocialSelected event) async* {
    yield LoginAttempted();
      
    try {
      UserCredential user;

      switch (event.social) {
        case Socials.google:
          user = await _authRepository.signInWithGoogle();
          break;
        case Socials.facebook:
          user = await _authRepository.signInWithFacebook();
          break;
        case Socials.apple:
          user = await _authRepository.signInWithApple();
          break;
      }

      final loginResponse = await _authRepository.oAuthSocialLogin(user.user!.email! ,user.user!.uid);
      if(loginResponse != null) {
        yield LoginSucceded();
      } else {
        throw Exception('Could not retrieve user data');
      }

    } catch (e) {
      yield LoginFailed(message: e.toString());
    }
  }
}
