import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'scan_qr_code_event.dart';
import 'scan_qr_code_state.dart';

class ScanQrCodeBloc extends Bloc<ScanQrCodeEvent, ScanQrCodeState> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller; // Make the controller nullable

  ScanQrCodeBloc() : super(ScanInitial());

  String? lastScannedData;

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    // AppLogger.i('start scan');
    add(StartScan());
  }

  void _processScanData(QRViewController controller) async {
    // AppLogger.i('process data');
    final scanData = await controller.scannedDataStream.first;
    lastScannedData = scanData.code;
    controller.pauseCamera();
    add(StopScan());
    add(ScanDataReceived(lastScannedData!));
  }

  // Add this method to resume the camera
  void resumeCamera() {
    if (controller != null) {
      controller!.resumeCamera();
    }
  }

  @override
  Stream<ScanQrCodeState> mapEventToState(ScanQrCodeEvent event) async* {
    if (event is StartScan) {
      _processScanData(controller!);
    } else if (event is StopScan) {
      controller?.dispose();
    } else if (event is ScanDataReceived) {
      yield ScanSuccess(event.qrCodeData);
    }
  }
}
