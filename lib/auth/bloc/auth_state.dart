part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {}

class AuthStateLoggedIn extends AuthState {
  AuthStateLoggedIn();
  @override
  List<Object> get props => [];
}

class AuthStateLoggedOut extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthStateError extends AuthState {
  final String error;
  AuthStateError({required this.error});
  @override
  List<Object?> get props => [error];
}
