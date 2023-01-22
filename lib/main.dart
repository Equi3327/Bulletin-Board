import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/login/login.dart';

import 'package:news_app/sign_up/sign_up.dart';
import 'package:news_app/home/home.dart';

import 'auth/bloc/auth_bloc.dart';
import 'flow.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        home: BlocProvider(
          create: (context) => AuthBloc(),
          child: ScreenController(),
        ),
      ),
    );
  }
}
