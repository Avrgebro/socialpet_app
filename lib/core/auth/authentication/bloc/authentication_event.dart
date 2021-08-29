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
  final String uuid;

  UnregisteredLogIn({required this.uuid});

  @override
  List<Object> get props => [uuid];

  @override
  String toString() => 'UnregisteredLogIn';
}

class UserLoggedIn extends AuthenticationEvent {
  final User user;

  UserLoggedIn({required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'LoggedIn';
}

class UserLoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}