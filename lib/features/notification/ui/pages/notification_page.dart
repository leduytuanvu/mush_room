import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              _buildTitle(theme),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  _buildAppBar() => AppBar(
    title: const Text("Notification"),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  );

  _buildTitle(ThemeData theme) => Text(
    "Privacy Policy",
    style: theme.textTheme.titleLarge,
  );
}
