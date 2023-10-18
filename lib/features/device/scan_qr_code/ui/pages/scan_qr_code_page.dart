import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/core/utils/app_logger.dart';
import 'package:mush_room/features/device/add_device/ui/pages/add_device_page.dart';
import 'package:mush_room/features/device/scan_qr_code/bloc/scan_qr_code_bloc.dart';
import 'package:mush_room/features/device/scan_qr_code/bloc/scan_qr_code_event.dart';
import 'package:mush_room/features/device/scan_qr_code/bloc/scan_qr_code_state.dart';
import 'package:mush_room/features/device/set_up_wifi/ui/pages/set_up_wifi_page.dart';
import 'package:mush_room/shared/widgets/mush_room_button_widget.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrCodePage extends StatelessWidget {
  const ScanQrCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final qrKey = GlobalKey(debugLabel: 'QR');
    final scanQrCodeBloc = injector<ScanQrCodeBloc>();
    return Scaffold(
      body: Column(
        children: [
          const Text("ScanQrCodePage"),
          Container(
            height: 300,
            width: 300,
            child: QRView(
              key: qrKey,
              onQRViewCreated: scanQrCodeBloc.onQRViewCreated,
            ),
          ),
          BlocBuilder<ScanQrCodeBloc, ScanQrCodeState>(
            bloc: scanQrCodeBloc,
            builder: (context, state) {
              AppLogger.i('1');
              if (state is ScanSuccess) {
                final qrCodeData = state.qrCodeData;
                AppLogger.i('2');
                if (qrCodeData.isNotEmpty) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) {
                        // Manually resume the camera when navigating back
                        scanQrCodeBloc.resumeCamera();
                        return SetUpWifiPage(qrCodeData: state.qrCodeData);
                      },
                    ));
                  });
                  return Text('QR Code Data: $qrCodeData');
                }
              } else {
                AppLogger.i('3');
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}


