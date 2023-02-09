import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocoding/geocoding.dart';
import 'package:news_app/repository/location_service.dart';
import 'package:news_app/repository/remote_config_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';

import 'package:news_app/news/widgets/news_widget.dart';
import '../../location/bloc/location_bloc.dart';
import '../bloc/news_bloc.dart';
import '../repositories/news_repository.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LocationBloc>(context).add(GetLocation());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationBlocState>(
      builder: (context, state) {
        if (state is LocationBlocLoading || state is LocationBlocInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LocationBlocError) {
          return Center(
            child: Flexible(
              child: Text(
                state.error,
              ),
            ),
          );
        } else if (state is LocationBlocLoaded) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 11, 35, 145),
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
                    const Icon(
                      Icons.near_me,
                      color: Colors.white,
                    ),
                    Text(
                      state.location,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                const Padding(
                    padding: EdgeInsets.only(
                  right: 10.0,
                ))
              ],
            ),
            body: BlocProvider(
              create: (context) => NewsBloc(newsRepository: NewsRepository()),
              child: NewsWidget(
                location: state.location == "India" ? "in" : "us",
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
