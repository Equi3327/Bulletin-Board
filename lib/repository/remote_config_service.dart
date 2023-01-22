import 'package:firebase_remote_config/firebase_remote_config.dart';

const String _showLocation = 'location';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;
  final defaults = <String, dynamic>{_showLocation: "IN"};
  RemoteConfigService({required FirebaseRemoteConfig remoteConfig})
      : _remoteConfig = remoteConfig;
  static late RemoteConfigService _instance;
  static Future<RemoteConfigService> getInstance() async {
    if (_instance == null) {
      _instance = RemoteConfigService(
        remoteConfig: FirebaseRemoteConfig.instance,
      );
    }
    return _instance;
  }

  String get showLocation => _remoteConfig.getString(_showLocation);

  Future initialise() async {
    try {
      await _remoteConfig.setDefaults(defaults);
      await _fetchAndActivate();
    } catch (e) {
      print("Remote COnfig fetch throttled: $e");
    }
  }

  Future _fetchAndActivate() async {
    await _remoteConfig.fetch();
    await _remoteConfig.activate();
  }
}
