import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mush_room/core/utils/app_logger.dart';
import 'package:mush_room/core/utils/app_text_style.dart';
import 'package:mush_room/features/device/scan_qr_code/ui/pages/scan_qr_code_page.dart';
import 'package:mush_room/gen/assets.gen.dart';
import 'package:mush_room/shared/widgets/button/mush_room_button_widget.dart';
import 'package:mush_room/shared/widgets/decoration/mush_room_decoration_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const channer = MethodChannel('leduytuanvu.com/tuanvu');

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final arguments = {'name': 'sara', 'pass': 'pass'};
    Future getBatteryLevel() async {
      final int newBatteryChannel =
          await HomePage.channer.invokeMethod('getBattery', arguments);
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
          _buildHeading(),
          Expanded(child: _buildListDevice()),
          const SizedBox(
            height: 16,
          ),
          // ElevatedButton(
          //     onPressed: () async {
          //       connectToWiFiAndDisableMobileData(
          //           'AnhTuDepTrai', '123456789');
          //       // await getBatteryLevel();
          //       // final success = await WifiConnection().connectToWifi('Suga 9', 'Pw\$suga@123');
          //       // if (success) {
          //       //   // Wi-Fi connection successful
          //       //   AppLogger.i("Wi-Fi connection successful");
          //       // } else {
          //       //   // Wi-Fi connection failed
          //       //   AppLogger.i("Wi-Fi connection failed");
          //       // }
          //     },
          //     child: const Text("SetUp"))
        ],
      ),
    );
  }

  _buildHeading() => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Expanded(child: Text("Device")),
            IconButton(
                onPressed: () {
                  AppLogger.d("iconAdd");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const ScanQrCodePage()));
                },
                splashColor: Colors.transparent,
                alignment: Alignment.centerRight,
                icon: Assets.icons.iconAdd.image(width: 20, height: 20)),
            IconButton(
                onPressed: () {
                  AppLogger.d("iconNotifcationGreen");
                },
                splashColor: Colors.transparent,
                alignment: Alignment.centerRight,
                icon: Assets.icons.iconNotifcationGreen
                    .image(width: 20, height: 20))
          ],
        ),
      );

  _buildListDevice() => ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, index) {
        return _buildItemDevice();
      },
      separatorBuilder: (context, index) => const SizedBox(
            height: 8,
          ),
      itemCount: 10);

  _buildItemDevice() => Container(
        padding: const EdgeInsets.all(16),
        decoration: MushRoomDecoration.defaultDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name Device", style: AppTextStyle.bodyTextStyleH3()),
            Row(
              children: [
                Expanded(
                    flex: 5,
                    child: _buildParameterDevice(
                        title: "Term: ",
                        parameter:
                            Text("°C", style: AppTextStyle.bodyTextStyleH4()))),
                Expanded(
                    flex: 5,
                    child: _buildParameterDevice(
                        title: "Led: ",
                        parameter: (Platform.isIOS)
                            ? CupertinoSwitch(
                                value: false, onChanged: (value) {})
                            : Switch(value: false, onChanged: (value) {}))),
              ],
            ),
            Row(
              children: [
                Expanded(
                    flex: 5,
                    child: _buildParameterDevice(
                        title: "Hum: ",
                        parameter:
                            Text("°C", style: AppTextStyle.bodyTextStyleH4()))),
                Expanded(
                    flex: 5,
                    child: _buildParameterDevice(
                        title: "Mist: ",
                        parameter: (Platform.isIOS)
                            ? CupertinoSwitch(
                                value: false, onChanged: (value) {})
                            : Switch(value: false, onChanged: (value) {}))),
              ],
            )
          ],
        ),
      );

  _buildParameterDevice({required String title, required Widget parameter}) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: AppTextStyle.bodyTextStyleH4(),
          ),
          parameter
        ],
      );
}

class ItemParameterDevice {
  String title;
  Widget parameter;

  ItemParameterDevice({required this.title, required this.parameter});
}
