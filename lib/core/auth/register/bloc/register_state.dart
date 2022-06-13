part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterAttempted extends RegisterState {}

class RegisterSucceded extends RegisterState {}

class RegisterFailed extends RegisterState {
  final String message;

  RegisterFailed({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'RegisterFailed';
}
