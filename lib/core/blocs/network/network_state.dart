part of 'network_bloc.dart';

enum ConnectivityStatus { online, offline, unknown }

enum NetworkDioStatus { online, offline, unknown }

class NetworkState extends Equatable {
  final ConnectivityStatus networkStatus;

  const NetworkState({this.networkStatus = ConnectivityStatus.offline});
  NetworkState copyWith({ConnectivityStatus? networkStatus}) {
    return NetworkState(networkStatus: networkStatus ?? this.networkStatus);
  }

  @override
  List<Object?> get props => [networkStatus];
}

class NetworkDioState extends NetworkState {
  final NetworkDioStatus networkDioStatus;
  const NetworkDioState({required this.networkDioStatus});
}
