import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mush_room/core/utils/app_logger.dart';

class SetUpWifiPage extends StatelessWidget {
  final String qrCodeData;
  const SetUpWifiPage({required this.qrCodeData, Key? key}) : super(key: key);

  // Future<bool> _onWillPop(BuildContext context) async {
  //   // This is an example of a confirmation dialog
  //   return await showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text('Do you really want to exit?'),
  //       actions: <Widget>[
  //         TextButton(
  //           child: Text('No'),
  //           onPressed: () => Navigator.of(context).pop(false),  // Returns false to onWillPop
  //         ),
  //         TextButton(
  //           child: Text('Yes'),
  //           onPressed: () => Navigator.of(context).pop(true),  // Returns true to onWillPop
  //         ),
  //       ],
  //     ),
  //   ) ?? false;  // Returns false if the dialog is dismissed
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return WillPopScope(
  //     onWillPop: () => _onWillPop(context),
  //     child: Scaffold(
  //       body: Text("SetUpWifiPage"),
  //     ),
  //   );
  // }

  static const channer = MethodChannel('leduytuanvu.com/tuanvu');

  @override
  Widget build(BuildContext context) {
    final arguments = {'name', 'sara'};
    Future getBatteryLevel() async {
      final int newBatteryChannel = await channer.invokeMethod('getBattery', arguments);
      AppLogger.i("newBatteryChannel: $newBatteryChannel");
    }
    return Scaffold(
        body: Column(children: [
          Text("SetUpWifiPage: $qrCodeData"),
          ElevatedButton(onPressed: () async {
            await getBatteryLevel();
            // final success = await WifiConnection().connectToWifi('Suga 9', 'Pw\$suga@123');
            // if (success) {
            //   // Wi-Fi connection successful
            //   AppLogger.i("Wi-Fi connection successful");
            // } else {
            //   // Wi-Fi connection failed
            //   AppLogger.i("Wi-Fi connection failed");
            // }
          }, child: const Text("SetUp"))
        ],)
    );
  }
}

// class SetUpWifiPage extends StatelessWidget {
//   final String qrCodeData;
//
//   const SetUpWifiPage({required this.qrCodeData, Key? key}) : super(key: key);
//
//   Future<bool> _onWillPop(BuildContext context) async {
//     // Navigate to the desired page when back button is pressed
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(
//         builder: (context) => AnotherPage(), // Replace with your destination page
//       ),
//     );
//
//     return false; // Return false to prevent showing the confirmation dialog
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () => _onWillPop(context),
//       child: Scaffold(
//         body: Text("SetUpWifiPage"),
//       ),
//     );
//   }
// }

// class WifiConnection {
//   static const MethodChannel _channel = MethodChannel('wifi_connection');
//
//   Future<bool> connectToWifi(String ssid, String password) async {
//     try {
//       final bool result = await _channel.invokeMethod(
//         'connectToWifi',
//         {'ssid': ssid, 'password': password},
//       );
//       return result;
//     } catch (e) {
//       print('Error connecting to Wi-Fi: $e');
//       return false;
//     }
//   }
// }

