import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'password_recovery_event.dart';
part 'password_recovery_state.dart';

class PasswordRecoveryBloc extends Bloc<PasswordRecoveryEvent, PasswordRecoveryState> {
  PasswordRecoveryBloc() : super(PasswordRecoveryInitial());

  @override
  Stream<PasswordRecoveryState> mapEventToState(
    PasswordRecoveryEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
