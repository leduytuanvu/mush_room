import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/features/device/add_device/ui/pages/add_device_page.dart';
import 'package:mush_room/features/device/scan_qr_code/bloc/scan_qr_code_bloc.dart';
import 'package:mush_room/features/device/scan_qr_code/bloc/scan_qr_code_state.dart';
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
            height: 300,  // Set a specific height
            width: 300,  // Set a specific width (optional)
            child: QRView(
              key: qrKey,
              onQRViewCreated: scanQrCodeBloc.onQRViewCreated,
            ),
          ),
          BlocBuilder<ScanQrCodeBloc, ScanQrCodeState>(
            bloc: scanQrCodeBloc,
            builder: (context, state) {
              if (state is ScanSuccess) {
                return Text('QR Code Data: ${state.qrCodeData}');
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

