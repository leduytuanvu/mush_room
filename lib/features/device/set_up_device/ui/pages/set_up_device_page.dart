import 'package:flutter/material.dart';
import 'package:mush_room/core/utils/app_constants.dart';
import 'package:mush_room/shared/widgets/text_field/mush_room_text_field_widget.dart';
import 'package:sizer/sizer.dart';

class SetUpDevicePage extends StatelessWidget {
  SetUpDevicePage({super.key});

  final FocusScopeNode node = FocusScopeNode();
  TextEditingController verificationTextEditingController =
      TextEditingController();

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
          " Device name",
          style: theme.textTheme.titleSmall!.copyWith(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
      );

  _buildBody(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            MushRoomTextFieldWidget(
              labelText: "Name device",
              textEditingController: verificationTextEditingController,
              // errorText: ((state is VerificationErrorSubmittedState) &&
              //         (state.codeError.isNotEmpty))
              //     ? state.codeError
              //     : null,
              node: node,
              hintText: "Enter verification code",
            ),
            SizedBox(height: 10),
            Text(
              "Set a misting schedule",
              style: theme.textTheme.titleSmall,
            ),
            SizedBox(height: 10),
            _buildItemSchedule(theme),
            _buildItemSchedule(theme),
            _buildItemAddSchedule(theme),
            SizedBox(height: 20),
            Text(
              "Humidity",
              style: theme.textTheme.titleSmall,
            ),
            SizedBox(height: 10),
            _buildHumidity(theme),
            SizedBox(height: 20),
            Text(
              "Set timeout",
              style: theme.textTheme.titleSmall,
            ),
            SizedBox(height: 10),
            _buildTimeOut(theme),
            SizedBox(height: 200),
          ],
        ),
      ),
    );
  }

  _buildItemSchedule(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Time on : 10:08",
                style: theme.textTheme.titleSmall!
                    .copyWith(fontSize: 13.sp, color: Colors.black54),
                maxLines: 3,
              ),
              Text(
                "Number of running minutes : 10 minutes",
                style: theme.textTheme.titleSmall!
                    .copyWith(fontSize: 13.sp, color: Colors.black54),
                maxLines: 3,
              ),
              Text(
                "Repeat : 4 times",
                style: theme.textTheme.titleSmall!
                    .copyWith(fontSize: 13.sp, color: Colors.black54),
                maxLines: 3,
              ),
              Text(
                "Number of repeat minutes : 60 minutes",
                style: theme.textTheme.titleSmall!
                    .copyWith(fontSize: 13.sp, color: Colors.black54),
                maxLines: 3,
              ),
              Text(
                "Day running : Monday",
                style: theme.textTheme.titleSmall!
                    .copyWith(fontSize: 13.sp, color: Colors.black54),
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildItemAddSchedule(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                Icons.add_circle,
                color: AppConstants.buttonColor,
                size: 30,
              ),
              SizedBox(width: 8),
              Text(
                "Add new schedule",
                style: theme.textTheme.titleSmall!
                    .copyWith(fontSize: 13.sp, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildHumidity(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upper threshold humidity : 30C",
                style: theme.textTheme.titleSmall!
                    .copyWith(fontSize: 13.sp, color: Colors.black54),
              ),
              Text(
                "Lower threshold humidity : 20C",
                style: theme.textTheme.titleSmall!
                    .copyWith(fontSize: 13.sp, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildTimeOut(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Timeout : 11:30",
            style: theme.textTheme.titleSmall!
                .copyWith(fontSize: 13.sp, color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
