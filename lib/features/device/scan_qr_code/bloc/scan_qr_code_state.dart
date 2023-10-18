import 'package:equatable/equatable.dart';

abstract class ScanQrCodeState extends Equatable {
  const ScanQrCodeState();

  @override
  List<Object> get props => [];
}

class ScanInitial extends ScanQrCodeState {}

class ScanSuccess extends ScanQrCodeState {
  final String qrCodeData;

  const ScanSuccess(this.qrCodeData);

  @override
  List<Object> get props => [qrCodeData];
}