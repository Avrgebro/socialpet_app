import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:socialpet/data/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  final AuthRepository _authRepository;

  RegisterBloc({required AuthRepository authRepository})
  : _authRepository = authRepository,
    super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterUserSelected) {
      yield* _mapRegisterUserToState(event);
    }
  }

  Stream<RegisterState> _mapRegisterUserToState(RegisterUserSelected event) async* {
    yield RegisterAttempted();
    var onFirebase = event.userdata.containsKey('firebase_uuid');
    if(!onFirebase) {
      try{
        UserCredential credentials = await _authRepository.signUp(event.userdata['email'], event.userdata['password']);
        event.userdata['firebase_uuid'] = credentials.user!.uid;
      } on FirebaseAuthException catch (e) {
        var errorCode = e.code;
        yield RegisterFailed(message: e.message!);
      }
      
    }
    
    //in here, the user already has all the fields ready to register using the app's api

    try {
      final registerResponse = await _authRepository.registerUser(event.userdata);
      if(registerResponse != null) {
          yield RegisterSucceded();
        } else {
          _authRepository.deleteUserFromFirebase(event.userdata['email']);
          yield RegisterFailed(message: 'Algo salió mal por nuestro lado, ya estamos trabajando para solucionarlo!');
        }
    } catch (e) {
      yield RegisterFailed(message: e.toString());
    }


  }
}
