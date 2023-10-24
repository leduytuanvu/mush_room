import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../custom/text/text.dart';

class MqttConstant {
  /// Host
  static const String iotServer = 'dev.combros.tech';

  /// Host certificate

  /// Port
  static const int port = 1883;

  /// Alive Period
  static const int alivePeriod = 20;

  /// Subscribe topic
  static const String subTopic = '';

  /// Publish topic
  static const String pubTopic = 'moonwalker';

  // /// Publish topic data
  // static const String pubTopicData = pubTopic + '/data/';
  //
  // /// Publish topic status
  // static const String pubTopicStatus = pubTopic + '/status/';

  /// Username
  static const String username = 'combros';

  /// Password
  static const String password = 'combros';

  static const String iotServerCertificate =
      'axn804m5xm2wy-ats.iot.ap-southeast-1.amazonaws.com';
  static const int portCertificate = 8883;
}

class ImeiDeviceNail {
  static String imei(String currentChair) {
    switch (currentChair) {
      case "chair 0":
        return "EC626083E0F8";
      case "chair 1":
        return "EC626084619C";
      case "chair 2":
        return "EC6260844310";
      case "chair 3":
        return "EC626083DE80";
      case "chair 4":
        return "EC6260828604";
      default:
        return "default";
    }
  }
}

class StatusReceiveMqtt {
  static bool status(String json) {
    int status = jsonDecode(json)["status"] ?? 0;
    debugPrint("status: $status");
    if (status == 1) {
      return true;
    } else {
      return false;
    }
  }
}

class Buttons {
  static String? buttonAction(int button) {
    Map<int, String> map = {
      1: "Auto Fill",
      2: "Fill",
      3: "Motor",
      4: "Mixing",
      5: "Drain",
      6: "Extra",
    };
    return map[button];
  }

  static String? buttonToMqtt(int button) {
    Map<int, String> map = {
      1: "autofill",
      2: "fill_",
      3: "motor",
      4: "mixing",
      5: "drain",
      6: "extra",
    };
    return map[button];
  }

  static Color colorButtons(int status) {
    switch (status) {
      case 0:
        return const Color(0xff8187FF);
      case 1:
        return const Color(0xff3d5afe);
      case 2:
        return const Color(0xff3d5afe);
      case 4:
        return const Color(0xff8187FF);
      case -99:
        return const Color(0xffEE4228);
      default:
        return const Color(0xff8187FF);
    }
  }
}

class DeviceWarning {
  String readWarning(int code) {
    switch (code) {
      case 101:
        return "Valve Cool cannot Open";
      case 102:
        return "Valve Cool cannot Close";
      case 103:
        return "Valve Hot cannot Open";
      case 104:
        return "Valve Hot cannot Close";
      case 105:
        return "Valve Drain cannot Open";
      case 106:
        return "Valve Drain cannot Close";
      case 201:
        return "Motor mix has issue";
      case 301:
        return "Motor drain has issue";
      case 401:
        return "Outlet has issue";

      default:
        return "Can't parse warning";
    }
  }
}

class Validation {
  static Widget errorText({required String errorText, required bool isShow}) {
    return SizedBox(
      height: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: isShow,
            child: Text(
              errorText,
              style: CustomText.errorText(),
            ),
          ),
        ],
      ),
    );
  }
}
