import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/blocs/localization/localization_bloc.dart';
import 'package:mush_room/core/blocs/theme/theme_bloc.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import '../firebase/firebase_message/firebase_message_bloc.dart';
import '../mqtt/mqtt_bloc.dart';
import '../network/network_bloc.dart';



class AppBloc {
  static final NetworkBloc networkBloc = NetworkBloc();
  static final MqttBloc mqttBloc = MqttBloc();
  static final FirebaseMessageBloc firebaseMessageBloc = FirebaseMessageBloc();
  static final ThemeBloc themeBloc = injector<ThemeBloc>();
  static final LocalizationBloc localizationBloc = injector<LocalizationBloc>();
  // static final DioBloc dioBloc = DioBloc();
  static final List<BlocProvider> providers = [
    BlocProvider<NetworkBloc>(
      create: (context) => networkBloc,
    ),
    BlocProvider<MqttBloc>(
      create: (context) => mqttBloc,
    ),
    BlocProvider<ThemeBloc>(create: (context) => themeBloc),
    BlocProvider<LocalizationBloc>(
        create: (context) => localizationBloc),
    BlocProvider<FirebaseMessageBloc>(
      create: (context) => firebaseMessageBloc,
    ),


  ];

  static void dispose() {
    networkBloc.close();
    mqttBloc.close();
    firebaseMessageBloc.close();
    themeBloc.close();
    localizationBloc.close();
    // manageDataBloc.close();
  }

  static final AppBloc _instance = AppBloc._internal();

  factory AppBloc() {
    return _instance;
  }

  AppBloc._internal();
}
