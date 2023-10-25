import 'package:flutter/material.dart';
import 'package:mush_room/core/utils/app_constants.dart';
import 'package:sizer/sizer.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

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
          " Support",
          style: theme.textTheme.titleSmall!.copyWith(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
      );

  _buildBody(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(26),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "If you have any questions, please contact two method above for support",
            style: theme.textTheme.titleSmall!.copyWith(fontSize: 14.sp),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Email: ",
                style: theme.textTheme.titleSmall!.copyWith(fontSize: 14.sp),
              ),
              Text(
                "combros@gmail.com",
                style: theme.textTheme.titleSmall!.copyWith(
                  fontSize: 14.sp,
                  color: AppConstants.linkColor,
                ),
              )
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hotline: ",
                style: theme.textTheme.titleSmall!.copyWith(fontSize: 14.sp),
              ),
              Text(
                "0909012344",
                style: theme.textTheme.titleSmall!.copyWith(
                  fontSize: 14.sp,
                  color: AppConstants.linkColor,
                ),
              ),
              Text(
                " | ",
                style: theme.textTheme.titleSmall!.copyWith(fontSize: 14.sp),
              ),
              Text(
                "0909012344",
                style: theme.textTheme.titleSmall!.copyWith(
                  fontSize: 14.sp,
                  color: AppConstants.linkColor,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
