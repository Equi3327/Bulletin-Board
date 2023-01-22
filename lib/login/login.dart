import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/auth/bloc/auth_bloc.dart';
import 'package:news_app/home/home.dart';
import 'package:news_app/repository/user_repository.dart';
import 'package:news_app/sign_up/sign_up.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final AuthService _auth = AuthService();
  GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // emailController
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return Home();
        }
        if (state is AuthStateLoggedOut) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              elevation: 0,
              title: const Text(
                "MyNews",
                style: TextStyle(
                  color: Color.fromARGB(255, 11, 35, 145),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Container(
              padding: const EdgeInsets.all(20.0),
              color: Colors.white,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: emailController,
                      // onFieldSubmitted: ((value) {
                      //   context.read<AuthBloc>().add(
                      //         AuthEventLogIn(
                      //           email: emailController.text,
                      //           password: passwordController.text,
                      //         ),
                      //       );
                      // }),
                      decoration: InputDecoration(
                        focusColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color.fromARGB(255, 11, 35, 145),
                              width: 1.0),
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
                        context.read<AuthBloc>().add(
                              AuthEventLogIn(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                      },
                      child: Text(
                        "Log In",
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 11, 35, 145),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    RichText(
                        text: TextSpan(
                            text: "New here? ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            children: [
                          TextSpan(
                              text: "Sign Up",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.read<AuthBloc>().emit(
                                      AuthStateLoggedOut(
                                          isLoading: false, successful: false));
                                  // Navigato
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const SignUp()),
                                  );
                                },
                              style: TextStyle(
                                color: const Color.fromARGB(255, 11, 35, 145),
                              )),
                        ])),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
