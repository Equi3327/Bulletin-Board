import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/auth/bloc/auth_bloc.dart';
import 'package:news_app/auth/screens/login.dart';

class ScreenFlow extends StatefulWidget {
  const ScreenFlow({super.key});

  @override
  State<ScreenFlow> createState() => _ScreenFlowState();
}

class _ScreenFlowState extends State<ScreenFlow> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const LoginPage(),
    );
  }
}
