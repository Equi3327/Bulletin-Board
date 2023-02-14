// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/auth/bloc/auth_bloc.dart';
import 'package:news_app/location/bloc/location_bloc.dart';
import 'package:news_app/news/screens/home.dart';
import 'package:news_app/auth/screens/sign_up.dart';
import 'package:news_app/repository/location_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late final SharedPreferences sharedPreferences;
  String? email;
  String? password;
  // late SharedPreferences loginData;

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  getUserId() async {
    sharedPreferences = await SharedPreferences.getInstance();
    email = sharedPreferences.getString("email");
    password = sharedPreferences.getString("password");
    if (email != null && password != null) {
      logIn(email: email, password: password);
    }
  }

  void goToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => AuthBloc(),
          child: const SignUp(),
        ),
      ),
    );
  }

  void logIn({required email, required password}) {
    BlocProvider.of<AuthBloc>(context).add(
      AuthEventLogIn(
        email: email,
        password: password,
      ),
    );
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
                create: (BuildContext context) => AuthBloc()),
            BlocProvider<LocationBloc>(
                create: (BuildContext context) =>
                    LocationBloc(locationServices: LocationServices())),
          ],
          child: const Home(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthState authState = AuthBloc().state;
    if (authState is AuthStateLoggedIn) {
      return const Home();
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: const Text(
            "Bulletin Board",
            style: TextStyle(
              color: Color.fromARGB(255, 11, 35, 145),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 11, 35, 145), width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelText: 'Email',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 11, 35, 145),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelText: 'Password',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () {
                  logIn(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                },
                // ignore: sort_child_properties_last
                child: const Text(
                  "Log In",
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 11, 35, 145),
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              RichText(
                  text: TextSpan(
                      text: "New here? ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      children: [
                    TextSpan(
                        text: "Sign Up",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            goToSignUp();
                          },
                        style: const TextStyle(
                          color: Color.fromARGB(255, 11, 35, 145),
                        )),
                  ])),
            ],
          ),
        ),
      );
    }
  }
}
