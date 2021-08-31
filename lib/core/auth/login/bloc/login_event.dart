part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginWithCredentialsSelected extends LoginEvent {
  final UserCredentials credentials;

  LoginWithCredentialsSelected({required this.credentials});

  @override
  List<Object> get props => [credentials];
}

class LoginWithSocialSelected extends LoginEvent {
  final Socials social;

  LoginWithSocialSelected({required this.social});

  @override
  List<Object> get props => [social];
}
