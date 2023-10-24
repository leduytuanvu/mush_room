import 'package:flutter/material.dart';

class WarrantlyInformationPage extends StatelessWidget {
  const WarrantlyInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: _buildAppBar(theme),
      body: _buildBody(theme),
    );
  }

  _buildAppBar(ThemeData theme) => AppBar(
        title: Text(
          " Warrantly Information",
          style: theme.textTheme.titleSmall!.copyWith(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
      );

  _buildBody(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildItem("Series", "4523765436875468", theme),
          Divider(),
          _buildItem("Warranty activation date", "24-10-2023", theme),
          Divider(),
          _buildItem("Warranty expiration date", "24-10-2024", theme),
        ],
      ),
    );
  }

  _buildItem(String title, String value, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            title,
            style: theme.textTheme.titleSmall,
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.bodySmall!.copyWith(color: Colors.black38),
          ),
        ],
      ),
    );
  }
}
