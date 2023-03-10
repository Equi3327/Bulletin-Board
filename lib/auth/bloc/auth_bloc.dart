// import 'dart:html';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:news_app/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateLoggedOut()) {
    on<AuthEventLogIn>((event, emit) async {
      try {
        await UserRepository()
            .signIn(email: event.email, password: event.password);
        emit(AuthStateLoggedIn());
      } on FirebaseAuthException catch (e) {
        debugPrint(e.toString());
        emit(
          AuthStateError(
            error: e.toString(),
          ),
        );
      } catch (e) {
        emit(
          AuthStateError(
            error: e.toString(),
          ),
        );
      }
    });
    on<AuthEventLogOut>((event, emit) async {
      await UserRepository().signOut();
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.clear();
      emit(AuthStateLoggedOut());
    });
    on<AuthEventSignUp>((event, emit) async {
      try {
        await UserRepository().signUp(
            name: event.name, email: event.email, password: event.password);
        emit(AuthStateLoggedIn());
      } on FirebaseAuthException catch (e) {
        debugPrint(e.toString());
        // authErrorLogin = e.toString();
        emit(
          AuthStateError(
            error: e.toString(),
          ),
        );
      }
    });
  }
}
