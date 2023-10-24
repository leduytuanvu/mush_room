import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nail_chair/bloc/firebase/firebase_message/firebase_message_bloc.dart';

import '../auth/auth_bloc.dart';
import '../mqtt/mqtt_bloc.dart';
import '../network/network_bloc.dart';
import '../websocket/websocket_bloc.dart';
import '../wifi_detected/wifi_detected_bloc.dart';


class AppBloc {
  static final NetworkBloc networkBloc = NetworkBloc();
  static final MqttBloc mqttBloc = MqttBloc();
  static final WifiDetectedBloc wifiDetectedBloc = WifiDetectedBloc();
  static final FirebaseMessageBloc firebaseMessageBloc = FirebaseMessageBloc();
  static final WebSocketBloc websocketBloc = WebSocketBloc();
  static final AuthBloc authBloc = AuthBloc();

  // static final DioBloc dioBloc = DioBloc();
  static final List<BlocProvider> providers = [
    BlocProvider<NetworkBloc>(
      create: (context) => networkBloc,
    ),
    BlocProvider<MqttBloc>(
      create: (context) => mqttBloc,
    ),
    BlocProvider<WifiDetectedBloc>(
      create: (context) => wifiDetectedBloc,
    ),
    BlocProvider<FirebaseMessageBloc>(
      create: (context) => firebaseMessageBloc,
    ),
    BlocProvider<WebSocketBloc>(
      create: (context) => websocketBloc,
    ),
    BlocProvider<AuthBloc>(
      create: (context) => authBloc,
    ),

  ];

  static void dispose() {
    networkBloc.close();
    mqttBloc.close();
    wifiDetectedBloc.close();
    // dioBloc.close();
    websocketBloc.close();
    authBloc.close();
    firebaseMessageBloc.close();
    // manageDataBloc.close();
  }

  static final AppBloc _instance = AppBloc._internal();

  factory AppBloc() {
    return _instance;
  }

  AppBloc._internal();
}
