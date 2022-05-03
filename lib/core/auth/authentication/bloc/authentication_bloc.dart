import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socialpet/config/constants/app_constants.dart';
import 'package:socialpet/data/models/user.dart';
import 'package:socialpet/data/repositories/auth_repository.dart';
import 'package:socialpet/utils/services/secure_storage_service.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  final AuthRepository _authRepository;

  AuthenticationBloc({required AuthRepository authRepository}) 
    : _authRepository = authRepository,
      super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppLoaded) {
      yield* _mapAppLoadedToState();
    } else if (event is UserLoggedIn) {
      yield* _mapUserLoggedInToState();
    } else if (event is UserLoggedOut) {
      yield* _mapUserLoggedOutToState();
    } else if (event is UnregisteredLogIn) {
      yield* _mapUnregisteredLogInToState();
    }
  }

  Stream<AuthenticationState> _mapAppLoadedToState() async* {
    yield Uninitialized();
    try {
      final isSignedIn = await _authRepository.isSignedIn();
      if (isSignedIn) {
        final user = await _authRepository.getAuthenticatedUser();  
        if (user != null){
          yield Authenticated(user: user);
        } else {
          yield Unregistered(uuid: await _authRepository.signedInUuid());
        }
        
      } else {
        yield Unauthenticated();
      }
    } catch (e) {
      yield Failure(message: e.toString());
    }

  }

  Stream<AuthenticationState> _mapUserLoggedInToState() async* {
    final user = await _authRepository.getAuthenticatedUser();
    if (user != null) {
      yield Authenticated(user: user);
    } else {
      yield Failure(message: 'Something went wrong');
    }
  }
    

  Stream<AuthenticationState> _mapUserLoggedOutToState() async* {
    yield Unauthenticated();
    _authRepository.signOut();
  }

  Stream<AuthenticationState> _mapUnregisteredLogInToState() async* {
    yield Unregistered(uuid: await _authRepository.signedInUuid());
  }
}
