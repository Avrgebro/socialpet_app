part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppLoaded extends AuthenticationEvent {
  @override
  String toString() => 'AppLoaded';
}

class UnregisteredLogIn extends AuthenticationEvent {
  final fb.User user;

  UnregisteredLogIn({required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'UnregisteredLogIn';
}

class UserLoggedIn extends AuthenticationEvent {
  @override
  String toString() => 'LoggedIn';
}

class UserLoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}