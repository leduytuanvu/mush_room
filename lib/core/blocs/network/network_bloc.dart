import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

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
      case ConnectivityResult.ethernet:
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
  }
}
