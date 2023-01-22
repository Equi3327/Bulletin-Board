import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/repository/auth_error.dart';
import 'package:news_app/repository/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateLoggedOut(isLoading: false, successful: false)) {
    on<AuthEventLogIn>((event, emit) async {
      try {
        emit(AuthStateLoggedOut(isLoading: true, successful: false));
        await UserRepository()
            .signIn(email: event.email, password: event.password);
        emit(AuthStateLoggedIn(isLoading: false, successful: true));
      } on FirebaseAuthException catch (e) {
        print(e);
        authErrorLogin = e.toString();
        emit(AuthStateLoggedOut(isLoading: false, successful: false));
      }
    });
    on<AuthEventLogOut>((event, emit) async {
      try {
        emit(AuthStateLoggedOut(isLoading: true, successful: false));
        await UserRepository().signOut();
        emit(AuthStateLoggedOut(isLoading: false, successful: true));
      } catch (e) {}
    });
    on<AuthEventSignUp>((event, emit) async {
      try {
        emit(AuthStateLoggedOut(isLoading: true, successful: false));
        await UserRepository()
            .signUp(email: event.email, password: event.password);
        emit(AuthStateLoggedIn(isLoading: false, successful: true));
      } on FirebaseAuthException catch (e) {
        print(e);
        authErrorLogin = e.toString();
        emit(AuthStateLoggedOut(isLoading: false, successful: false));
      }
    });
  }
}
