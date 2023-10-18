import 'package:equatable/equatable.dart';
import 'package:mush_room/features/device/scan_qr_code/bloc/scan_qr_code_event.dart';

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