import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/auth/bloc/auth_bloc.dart';
import 'package:news_app/news/screens/home.dart';
import 'package:news_app/auth/screens/login.dart';
import 'package:news_app/repository/user_repository.dart';
import 'package:news_app/auth/screens/sign_up.dart';

class ScreenController extends StatelessWidget {
  const ScreenController({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: UserRepository().authStateChanges,
      builder: (context, snapshot) {
        return BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthStateLoggedOut) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "You are logged Out",
                  ),
                ),
              );
            }
            if (state is AuthStateLoggedIn) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "You are logged In",
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthStateLoggedIn) {
              return Home();
            }
            if (state is AuthStateLoggedOut) {
              return LoginPage();
            }
            if (state is AuthStateError) {
              return const Center(
                child: Text(
                  "Error occured while Authentication",
                ),
              );
            } else {
              return Container();
            }
          },
        );
      },
    );
  }
}
