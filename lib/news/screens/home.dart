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
import '../bloc/news_bloc.dart';
import '../repositories/news_repository.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String location = "us";
  String country = "IN";
  //final RemoteConfigService remoteConfigService = RemoteConfigService();

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    // location = await remoteConfigService.initialize();
    // final remoteConfig = FirebaseRemoteConfig.instance;
    // await remoteConfig.fetch();
    // var value = await remoteConfigService.initialize();
    // await remoteConfig.activate();
    // setState(() {
    //   // location = remoteConfig.getString("location");
    //   location = value;
    // });
    // });
  }

  Future<String> getLocation() async {
    final LocationServices locationServices = LocationServices();
    final LocationData? locationData = await locationServices.getLocation();
    String countryName = "JP";
    if (locationData != null) {
      final placemark =
          await locationServices.getPlaceMark(locationData: locationData);
      countryName = placemark?.country ?? "US";
    }
    return countryName;
  }

  @override
  Widget build(BuildContext context) {
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
              IconButton(
                icon: const Icon(Icons.near_me),
                onPressed: () async {
                  var newCountry = await getLocation();
                  setState(() {
                    country = newCountry;
                  });
                },
                color: Colors.white,
              ),
              Text(
                location,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              Text(
                country,
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
          location: location,
        ),
      ),
    );
  }
}
