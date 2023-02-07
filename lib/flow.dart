import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/auth/bloc/auth_bloc.dart';
import 'package:news_app/news/screens/home.dart';
import 'package:news_app/auth/screens/login.dart';
import 'package:news_app/repository/user_repository.dart';

class ScreenController extends StatelessWidget {
  const ScreenController({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateLoggedOut) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "You are logged Out",
              ),
            ),
          );
        } else if (state is AuthStateLoggedIn) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "You are logged In",
              ),
            ),
          );
        } else if (state is AuthStateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const Home();
        } else if (state is AuthStateLoggedOut) {
          return const LoginPage();
        } else if (state is AuthStateError) {
          return const LoginPage();
        } else {
          return Container();
        }
      },
    );
  }
}
