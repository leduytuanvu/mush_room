
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/core/utils/app_logger.dart';
import 'package:mush_room/features/device/scan_qr_code/bloc/scan_qr_code_bloc.dart';
import 'package:mush_room/features/device/scan_qr_code/bloc/scan_qr_code_state.dart';
import 'package:mush_room/features/device/set_up_wifi/ui/pages/set_up_wifi_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrCodePage extends StatefulWidget {
   ScanQrCodePage({Key? key}) : super(key: key);

  @override
  State<ScanQrCodePage> createState() => _ScanQrCodePageState();
}

class _ScanQrCodePageState extends State<ScanQrCodePage> {
  final qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scanQrCodeBloc = injector<ScanQrCodeBloc>();
    return Scaffold(
      appBar: AppBar(
        title :Text(" Device", style: theme.textTheme.titleMedium!.copyWith(color: Colors.white),),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [

          Expanded(child: _buildQrView(scanQrCodeBloc)),
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

  Widget _buildQrView(ScanQrCodeBloc scanQrCodeBloc) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = 250.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: scanQrCodeBloc.onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: const Color(0xff100CCC),
          borderRadius: 8,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

   void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
     if (!p) {
       Permission.camera.request();
     }
   }
}


