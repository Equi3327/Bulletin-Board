part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthEventLogIn extends AuthEvent {
  final String email;
  final String password;
  const AuthEventLogIn({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}

class AuthEventSignUp extends AuthEvent {
  final String name;
  final String email;
  final String password;
  const AuthEventSignUp(
      {required this.name, required this.email, required this.password});
  @override
  List<Object> get props => [name, email, password];
}

class AuthEventLogOut extends AuthEvent {
  AuthEventLogOut();
  @override
  List<Object> get props => throw UnimplementedError();
}
