import 'package:flutter/material.dart';
import 'package:mush_room/features/device/add_device/ui/pages/add_device_page.dart';
import 'package:mush_room/features/device/scan_qr_code/ui/pages/scan_qr_code_page.dart';
import 'package:mush_room/shared/widgets/mush_room_button_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          const Text("HomePage"),
          MushRoomButtonWidget(
              label: "Add device",
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ScanQrCodePage()));
              },
              paddingTop: 10,
            ),
        ],
      ),
    );
  }
}
