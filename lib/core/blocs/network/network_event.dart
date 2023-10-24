import 'package:equatable/equatable.dart';

import 'network_bloc.dart';

class NetworkEvent extends Equatable {
  const NetworkEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NetworkObserve extends NetworkEvent {}

class NetworkNotify extends NetworkEvent {
  final ConnectivityStatus networkStatus;

  const NetworkNotify({
    required this.networkStatus,
  });
}

class NetworkDio extends NetworkEvent {
  final NetworkDioStatus networkDio;

  const NetworkDio({
    required this.networkDio,
  });
}
