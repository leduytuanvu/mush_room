import 'package:flutter/material.dart';
import 'package:mush_room/shared/widgets/combo_box/mush_room_combo_box_widget.dart';

class DeviceDetailPage extends StatelessWidget {
  const DeviceDetailPage({super.key});

  void handleChange(String? customer) {

  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: _buildAppBar(theme),
      body: Column(
        children: [
          Text("Regime"),
          MushRoomComboBoxWidget(listItem: ["Manual", "Factual"], onChanged: handleChange)
        ],
      ),
    );
  }

  _buildAppBar(ThemeData theme) => AppBar(
    title: Text("Name device", style: theme.textTheme.titleSmall!.copyWith(color: Colors.white),),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    centerTitle: true,
  );
}
