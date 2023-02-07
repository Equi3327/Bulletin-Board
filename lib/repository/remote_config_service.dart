import 'package:firebase_remote_config/firebase_remote_config.dart';

const String _showLocation = 'location_info';

class RemoteConfigService {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  Future initialize() async {
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 1),
        minimumFetchInterval: const Duration(seconds: 5),
      ),
    );
    await remoteConfig.fetchAndActivate();
    var temp = remoteConfig.getString(_showLocation);
    return temp;
  }

  // final defaults = <String, dynamic>{_showLocation: "us"};

  // RemoteConfigService({required FirebaseRemoteConfig remoteConfig})
  //     : _remoteConfig = remoteConfig;

  // static late RemoteConfigService _instance;

  // static Future<RemoteConfigService> getInstance() async {
  //   return _instance ??
  //       RemoteConfigService(
  //         remoteConfig: FirebaseRemoteConfig.instance,
  //       );
  // }

//   String get showLocation => _remoteConfig.getString(_showLocation);

//   Future initialise() async {
//     try {
//       await _remoteConfig.setDefaults(defaults);
//       await _fetchAndActivate();
//     } catch (e) {
//       print("Remote Config fetch throttled: $e");
//     }
//   }

//   Future _fetchAndActivate() async {
//     await _remoteConfig.fetch();
//     await _remoteConfig.activate();
//   }
}
