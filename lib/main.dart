import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/auth/screens/login.dart';

import 'package:news_app/auth/screens/sign_up.dart';
import 'package:news_app/news/screens/home.dart';

import 'auth/bloc/auth_bloc.dart';
import 'bloc_observer.dart';
import 'flow.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => AuthBloc(),
        child: ScreenController(),
      ),
    );
  }
}
