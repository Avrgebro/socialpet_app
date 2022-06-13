import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:socialpet/core/auth/login/bloc/login_bloc.dart';
import 'package:socialpet/data/repositories/auth_repository.dart';

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
    
  }
}
