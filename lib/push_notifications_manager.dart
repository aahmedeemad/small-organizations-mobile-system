import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsManager {
  String _token;
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  String get token {
    return _token;
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
      //_firebaseMessaging.configure();
      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('on message $message');
        },
        onResume: (Map<String, dynamic> message) async {
          print('on resume $message');
        },
        onLaunch: (Map<String, dynamic> message) async {
          print('on launch $message');
        },
      );
      _firebaseMessaging.subscribeToTopic('');

      // For testing purposes print the Firebase Messaging token
      _token = await _firebaseMessaging.getToken();
      print('token is : $_token');
      _initialized = true;
    }
  }
}
