part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginAttempted extends LoginState {}

class LoginSucceded extends LoginState {}

class LoginUnregistered extends LoginState {
  final User user;

  LoginUnregistered({required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'LoginUnregistered';
}

class LoginFailed extends LoginState {
  final String message;

  LoginFailed({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'LoginFailed';
}

class LoginWithSocial extends LoginState {
  final Socials social;

  LoginWithSocial({required this.social});

  @override
  List<Object> get props => [social];

  @override
  String toString() => 'LoginWithSocial';
}