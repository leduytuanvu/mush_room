import 'package:equatable/equatable.dart';

abstract class ScanQrCodeEvent extends Equatable {
  const ScanQrCodeEvent();

  @override
  List<Object> get props => [];
}

class StartScan extends ScanQrCodeEvent {}

class StopScan extends ScanQrCodeEvent {}

class ScanDataReceived extends ScanQrCodeEvent {
  final String qrCodeData;

  const ScanDataReceived(this.qrCodeData);
}