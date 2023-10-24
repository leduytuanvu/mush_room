import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/blocs/app_bloc/app_bloc.dart';
import 'package:mush_room/core/blocs/mqtt/mqtt_event.dart';
import 'package:mush_room/core/blocs/mqtt/mqtt_state.dart';

import 'network_event.dart';

part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  NetworkDioStatus networkDioStatus = NetworkDioStatus.unknown;

  NetworkBloc._() : super(const NetworkState()) {
    on<NetworkObserve>(_observe);
    on<NetworkNotify>(_notifyStatus);
  }

  static final NetworkBloc _instance = NetworkBloc._();

  factory NetworkBloc() => _instance;

  void _observe(event, emit) {
    Connectivity().onConnectivityChanged.listen((result) {
      connectionController.add(getStatus(result));
    });
  }

  StreamController<ConnectivityStatus> connectionController =
      StreamController<ConnectivityStatus>();

  ConnectivityStatus getStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        add(const NetworkNotify(
          networkStatus: ConnectivityStatus.online,
        ));
        return ConnectivityStatus.online;
      case ConnectivityResult.mobile:
        add(const NetworkNotify(
          networkStatus: ConnectivityStatus.online,
        ));
        return ConnectivityStatus.online;
      case ConnectivityResult.none:
        add(const NetworkNotify(
          networkStatus: ConnectivityStatus.offline,
        ));
        return ConnectivityStatus.offline;
      default:
        add(const NetworkNotify(
          networkStatus: ConnectivityStatus.offline,
        ));
        return ConnectivityStatus.offline;
    }
  }

  void _notifyStatus(NetworkNotify event, emit) {
    emit(state.copyWith(networkStatus: event.networkStatus));
    switch (state.networkStatus) {
      case ConnectivityStatus.online:
        if (AppBloc.mqttBloc.state.mqttStatus != MqttStatus.connected) {
          AppBloc.mqttBloc.add(const MqttConnect());
        }

      case ConnectivityStatus.offline:
        if (AppBloc.mqttBloc.state.mqttStatus == MqttStatus.connected) {
          AppBloc.mqttBloc.add(MqttDisconnect());
        }

      case ConnectivityStatus.unknown:
      // TODO: Handle this case.
    }
  }
}
