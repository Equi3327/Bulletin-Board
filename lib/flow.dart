import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/auth/bloc/auth_bloc.dart';
import 'package:news_app/home/home.dart';
import 'package:news_app/login/login.dart';
import 'package:news_app/repository/user_repository.dart';
import 'package:news_app/sign_up/sign_up.dart';

class ScreenController extends StatelessWidget {
  const ScreenController({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: UserRepository().authStateChanges,
      builder: (context, snapshot) {
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthStateLoggedIn) {
              return Home();
            }
            if (state is AuthStateLoggedOut) {
              return LoginPage();
            } else {
              return Container();
            }
          },
        );
      },
    );
  }
}
