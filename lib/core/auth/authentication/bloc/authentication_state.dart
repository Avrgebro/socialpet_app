part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class Uninitialized extends AuthenticationState {}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'Unauthenticated';
}

class Authenticated extends AuthenticationState {
  final User user;

  Authenticated({required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'Authenticated';

}

class Failure extends AuthenticationState {
  final String message;

  Failure({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'Failure';
}
