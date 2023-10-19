import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mush_room/core/utils/app_logger.dart';
import 'package:mush_room/features/device/scan_qr_code/ui/pages/scan_qr_code_page.dart';
import 'package:mush_room/shared/widgets/button/mush_room_button_widget.dart';
import 'package:wifi_iot/wifi_iot.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const channer = MethodChannel('leduytuanvu.com/tuanvu');
  @override
  Widget build(BuildContext context) {
    final arguments = {'name': 'sara', 'pass': 'pass'};
    Future getBatteryLevel() async {
      final int newBatteryChannel =
          await channer.invokeMethod('getBattery', arguments);
      AppLogger.i("newBatteryChannel: $newBatteryChannel");
    }
    ///new merge

    Future<void> connectToWiFiAndDisableMobileData(
        String ssid, String password) async {
      try {
        // Disable mobile data
        final ConnectivityResult connectivityResult =
            await Connectivity().checkConnectivity();
        if (connectivityResult == ConnectivityResult.mobile) {
          // Mobile data is enabled, you can choose to disable it here
          // Be sure to handle this action with proper permissions and user consent.
        }

        // Connect to WiFi
        await WiFiForIoTPlugin.connect(
          ssid,
          password: password,
          security: NetworkSecurity.WPA, // or NetworkSecurity.WEP if applicable
        );

        print('Connected to WiFi: $ssid');
      } catch (e) {
        print('Failed to connect to WiFi: $e');
      }
    }

    return Scaffold(
      body: Column(
        children: [
          const Text("HomePage"),
          MushRoomButtonWidget(
            label: "Add device",
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ScanQrCodePage()));
            },
            paddingTop: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                connectToWiFiAndDisableMobileData('AnhTuDepTrai', '123456789');
                // await getBatteryLevel();
                // final success = await WifiConnection().connectToWifi('Suga 9', 'Pw\$suga@123');
                // if (success) {
                //   // Wi-Fi connection successful
                //   AppLogger.i("Wi-Fi connection successful");
                // } else {
                //   // Wi-Fi connection failed
                //   AppLogger.i("Wi-Fi connection failed");
                // }
              },
              child: const Text("SetUp"))
        ],
      ),
    );
  }
}
