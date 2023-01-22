import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/home/views/news_widget.dart';
import 'package:news_app/repository/remote_config_service.dart';

import '../news/bloc/news_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String location = "";
  // final RemoteConfigService remoteConfigService;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final remoteConfig = await FirebaseRemoteConfig.instance;
      final defaults = <String, dynamic>{"location": "IN"};
      await remoteConfig.fetch();
      await remoteConfig.activate();
      setState(() {
        location = remoteConfig.getString("location");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 11, 35, 145),
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          "MyNews",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Row(
            children: [
              Icon(
                Icons.near_me,
                color: Colors.white,
              ),
              Text(
                location,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
          Padding(
              padding: EdgeInsets.only(
            right: 10.0,
          ))
        ],
      ),
      body: BlocProvider(
        create: (context) => NewsBloc(),
        child: NewsWidget(),
      ),
    );
  }
}
