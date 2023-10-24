import 'package:mush_room/core/blocs/app_bloc/app_bloc.dart';

class MqttConstantTopic {
  MqttConstantTopic._privateConstructor();

  // Private static instance variable
  static final MqttConstantTopic _instance =
      MqttConstantTopic._privateConstructor();

  // Public static getter to access the instance
  static MqttConstantTopic get instance => _instance;
  static String baseTopic = "local_khimdev";

  List<String> listTopicSubscribed({required String imei}) => [
    topicReceiveTest(),
        // topicDeviceStatusAndFirmware(imei: imei),
        // topicConfigTemps(imei: imei),
        // topicSensorTemps(imei: imei),
        // topicButtons(imei: imei),
        // topicStatusDevice(imei: imei),
        // topicButtons(imei: imei),
        // // topicGetInitDevice(imei: imei),
        // topicReceiveControlModeDevice(imei: imei),
        // topicReceiveModeWaterDischarge(imei: imei),
        // topicReceiveSetValue(imei: imei),
        // topicReceiveSetService(imei: imei),
        // topicReceiveCancelService(imei: imei),
        // topicReceiveFingerprint(imei: imei),
        // topicListenWarmUp(imei: imei),
        // topicReceiveDeleteFingerprint(imei: imei),
      ];
  ///sendTest
  static String topicTest() => "$baseTopic/sendTest";
  ///receiveTest
  static String topicReceiveTest() => "$baseTopic/receiveTest";

  static String topicDeviceStatusAndFirmware({required String imei}) =>
      "$baseTopic/iot/nailchair/device/lastwill/${AppBloc.mqttBloc.currentImei}";

  ///status device nail
  static String topicStatusDevice({required String imei}) =>
      "$baseTopic/iot/nailchair/mobile/status/${AppBloc.mqttBloc.currentImei}";

  ///Config temp
  static String topicConfigTemps({required String imei}) =>
      "$baseTopic/iot/nailchair/device/temperature/${AppBloc.mqttBloc.currentImei}";

  static String topicSensorTemps({required String imei}) =>
      "$baseTopic/iot/nailchair/mobile/updateTemperature/${AppBloc.mqttBloc.currentImei}";

  ///Button
  static String topicButtons({required String imei}) =>
      "$baseTopic/iot/nailchair/mobile/button/${AppBloc.mqttBloc.currentImei}";

  static String topicControlButtons({required String imei}) =>
      "$baseTopic/iot/nailchair/mobile/control/${AppBloc.mqttBloc.currentImei}";

  ///OTA
  static String topicControlOTA({required String imei}) =>
      "$baseTopic/iot/nailchair/device/ota/${AppBloc.mqttBloc.currentImei}";

  // static String topicGetInitDevice({required String imei}) =>
  //     "$baseTopic/iot/nailchair/device/getinfo/$imei";

  // static String topicInitDevice({required String imei}) =>
  //     "$baseTopic/iot/nailchair/device/rgetinfo/$imei";

  ///Mode device
  static String topicControlModeDevice({required String imei}) =>
      "$baseTopic/iot/nailchair/mobile/modeControl/${AppBloc.mqttBloc.currentImei}";

  static String topicReceiveControlModeDevice({required String imei}) =>
      "$baseTopic/iot/nailchair/device/receiveModeControl/${AppBloc.mqttBloc.currentImei}";

  ///Mode Discharge
  static String topicControlModeDischarge({required String imei}) =>
      "$baseTopic/iot/nailchair/mobile/modeWaterDischarge/${AppBloc.mqttBloc.currentImei}";

  static String topicReceiveModeWaterDischarge({required String imei}) =>
      "$baseTopic/iot/nailchair/device/receiveModeWaterDischarge/${AppBloc.mqttBloc.currentImei}";

  ///Set Valve
  static String topicSetValve({required String imei}) =>
      "$baseTopic/iot/nailchair/mobile/setValve/${AppBloc.mqttBloc.currentImei}";

  static String topicReceiveSetValue({required String imei}) =>
      "$baseTopic/iot/nailchair/device/receiveSetVale/${AppBloc.mqttBloc.currentImei}";

  ///Warning
  static String topicReceiveWarning({required String imei}) =>
      "$baseTopic/iot/nailchair/device/warning/${AppBloc.mqttBloc.currentImei}";

  ///Service
  static String topicSetService({required String imei}) =>
      "$baseTopic/iot/nailchair/mobile/setService/${AppBloc.mqttBloc.currentImei}";

  static String topicReceiveSetService({required String imei}) =>
      "$baseTopic/iot/nailchair/device/receiveSetService/${AppBloc.mqttBloc.currentImei}";

  static String topicCancelService({required String imei}) =>
      "$baseTopic/iot/nailchair/mobile/cancelService/${AppBloc.mqttBloc.currentImei}";

  static String topicReceiveCancelService({required String imei}) =>
      "$baseTopic/iot/nailchair/device/receiveCancelService/${AppBloc.mqttBloc.currentImei}";

  ///Fingerprint
  static String topicStartFingerprint({required String imei}) =>
      "$baseTopic/iot/nailchair/device/addFingerprint/${AppBloc.mqttBloc.currentImei}";

  static String topicReceiveFingerprint({required String imei}) =>
      "$baseTopic/iot/nailchair/mobile/receiveAddFingerprint/${AppBloc.mqttBloc.currentImei}";

  /// delete fingerprint
  static String topicDeleteFingerprint({required String imei}) =>
      "$baseTopic/iot/nailchair/device/deleteFingerprint/${AppBloc.mqttBloc.currentImei}";

  static String topicReceiveDeleteFingerprint({required String imei}) =>
      "$baseTopic/iot/nailchair/device/receiveDeleteFingerprint/${AppBloc.mqttBloc.currentImei}";

  ///Warm up
  static String topicListenWarmUp({required String imei}) =>
      "$baseTopic/iot/nailchair/device/warmup/${AppBloc.mqttBloc.currentImei}";
}
