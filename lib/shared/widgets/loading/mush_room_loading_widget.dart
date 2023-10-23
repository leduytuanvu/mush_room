import 'package:flutter/material.dart';

class MushRoomLoadingWidget extends StatelessWidget {
  const MushRoomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5), // Adjust opacity as needed
      width: double.infinity,
      height: double.infinity,
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
