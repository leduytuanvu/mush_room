import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mush_room/core/dependency_injection/injector.dart';
import 'package:mush_room/core/mqtt/mqtt_publish.dart';
import 'package:mush_room/core/utils/app_constants.dart';
import 'package:mush_room/core/utils/app_logger.dart';
import 'package:mush_room/core/utils/app_router.dart';
import 'package:mush_room/core/utils/app_text_style.dart';
import 'package:mush_room/features/device/device_detail/ui/pages/device_detail_page.dart';
import 'package:mush_room/features/device/home/bloc/home_bloc.dart';
import 'package:mush_room/features/device/home/bloc/home_event.dart';
import 'package:mush_room/features/device/notification/ui/pages/notification_page.dart';
import 'package:mush_room/features/device/scan_qr_code/ui/pages/scan_qr_code_page.dart';
import 'package:mush_room/gen/assets.gen.dart';
import 'package:mush_room/shared/widgets/decoration/mush_room_decoration_widget.dart';
import 'package:wifi_iot/wifi_iot.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const channer = MethodChannel('leduytuanvu.com/tuanvu');

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final homeBloc = injector<HomeBloc>();

  Future<void> _handleRefresh() async {
    // Implement your refresh logic here.
    // You can fetch new data or perform any other refresh action.
    // For example, you can call an API to get the latest notifications.
    homeBloc.add(HomeRefreshEvent()); // Simulating a delay
  }

  final arguments = {'name': 'sara', 'pass': 'pass'};

  Future getBatteryLevel() async {
    final int newBatteryChannel =
        await HomePage.channer.invokeMethod('getBattery', arguments);
    AppLogger.i("newBatteryChannel: $newBatteryChannel");
  }

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Scaffold(
          appBar: _buildAppBar(context, theme),
          body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _handleRefresh,
            child: Column(
              children: [
                // _buildHeading(),
                Expanded(child: _buildListDevice()),

              ],
            ),
          ),
        ),
        // BlocBuilder<HomeBloc, HomeState>(
        //     bloc: homeBloc, // Using bottomBarBloc directly
        //     builder: (context, state) {
        //       if (state is HomeLoadingState) {
        //         return MushRoomLoadingWidget();
        //       } else {
        //         return const SizedBox.shrink();
        //       }
        //     })
        // MushRoomLoadingWidget(),
        // Stack(
        //   children: [
        //     Container(color: Colors.black.withOpacity(0.5), ),
        //     Center(
        //       child: Container(
        //         decoration: BoxDecoration(
        //           color: Colors.white,
        //           borderRadius: BorderRadius.circular(10),
        //           boxShadow:  <BoxShadow>[
        //             BoxShadow(
        //               offset: Offset(1.0, 1.0),
        //               blurRadius: 8.0,
        //               color: Colors.grey,
        //             ),
        //           ],
        //         ),
        //         height: screenHeight*0.6, width: screenWidth*0.9,
        //         child: Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Column(children: [
        //             Align(
        //               alignment: Alignment.centerRight,
        //               child: Icon(Icons.close),
        //             ),
        //             Icon(Icons.logo_dev, size: 150,),
        //             Text("Are you sure to Are y?"),
        //             Row(children: [
        //               Expanded(child: MushRoomButtonWidget(label: "label", onPressed: (){})),
        //               Expanded(child: MushRoomButtonWidget(label: "label", onPressed: (){})),
        //             ],)
        //           ],),
        //         ),
        //       ),
        //     ),
        //   ],
        // )
      ],
    );
  }

  _buildAppBar(BuildContext context, ThemeData theme) => AppBar(
        title: Text(
          "Device",
          style: theme.textTheme.titleMedium!.copyWith(color: Colors.white),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              appNavigation(ScanQrCodePage());
            },
            child: Assets.icons.iconAdd.image(width: 19, height: 19),
          ),
          SizedBox(width: 20),
          GestureDetector(
            onTap: () {
              // Handle the button click here
              // You can navigate to another screen or perform any other action
              appNavigation(NotificationPage());
            },
            child:
                Assets.icons.iconNotifcationGreen.image(width: 19, height: 19),
          ),
          // IconButton(
          //     onPressed: () {
          //       AppLogger.d("iconAdd");
          //       Navigator.of(context).push(MaterialPageRoute(
          //           builder: (_) =>  ScanQrCodePage()));
          //     },
          //     splashColor: Colors.transparent,
          //     alignment: Alignment.centerRight,
          //     icon: Assets.icons.iconAdd.image(width: 19, height: 19)),
          // IconButton(
          //     onPressed: () {
          //       appNavigation(NotificationPage());
          //     },
          //     splashColor: Colors.transparent,
          //     alignment: Alignment.centerRight,
          //     icon: Assets.icons.iconNotifcationGreen
          //         .image(width: 20, height: 20)),
          SizedBox(width: 22),
        ],
      );

  _buildHeading() => Container(
        height: 60,
        color: AppConstants.appBarColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Expanded(child: Text("Device")),
              IconButton(
                  onPressed: () {
                    AppLogger.d("iconAdd");
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => ScanQrCodePage()));
                  },
                  splashColor: Colors.transparent,
                  alignment: Alignment.centerRight,
                  icon: Assets.icons.iconAdd.image(width: 19, height: 19)),
              IconButton(
                  onPressed: () {
                    appNavigation(NotificationPage());
                  },
                  splashColor: Colors.transparent,
                  alignment: Alignment.centerRight,
                  icon: Assets.icons.iconNotifcationGreen
                      .image(width: 20, height: 20))
            ],
          ),
        ),
      );

  _buildListDevice() => ListView.separated(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            appNavigation(DeviceDetailPage());
          },
          child: _buildItemDevice(),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
            height: 12,
          ),
      itemCount: 10);

  _buildItemDevice() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: MushRoomDecoration.defaultDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name Device", style: AppTextStyle.bodyTextStyleH3()),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                    flex: 5,
                    child: _buildParameterDevice(
                        title: "Term   :  ",
                        parameter: Text(" °C",
                            style: AppTextStyle.bodyTextStyleH4()))),
                Expanded(
                    flex: 5,
                    child: _buildParameterDevice(
                        title: "Led    : ",
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
                        title: "Hum   :  ",
                        parameter: Text(" °C",
                            style: AppTextStyle.bodyTextStyleH4()))),
                Expanded(
                    flex: 5,
                    child: _buildParameterDevice(
                        title: "Mist    : ",
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
