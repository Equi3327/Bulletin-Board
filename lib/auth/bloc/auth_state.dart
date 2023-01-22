part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final bool isLoading;
  final bool successful;
  const AuthState({required this.isLoading, required this.successful});

  @override
  List<Object> get props => [];
}

class AuthStateLoggedIn extends AuthState {
  AuthStateLoggedIn({required super.isLoading, required super.successful});
  @override
  List<Object> get props => [isLoading, successful];
}

class AuthStateLoggedOut extends AuthState {
  AuthStateLoggedOut({required super.isLoading, required super.successful});
  @override
  List<Object> get props => [isLoading, successful];
}
