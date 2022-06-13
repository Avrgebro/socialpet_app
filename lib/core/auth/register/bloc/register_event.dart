part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterUserSelected extends RegisterEvent {
  final Map<String,dynamic> userdata;

  RegisterUserSelected({required this.userdata});

  @override
  List<Object> get props => [userdata];

}
