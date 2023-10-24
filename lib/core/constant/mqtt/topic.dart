class MqttConstantTopic {
  MqttConstantTopic._privateConstructor();

  // Private static instance variable
  static final MqttConstantTopic _instance =
      MqttConstantTopic._privateConstructor();

  // Public static getter to access the instance
  static MqttConstantTopic get instance => _instance;
  static String baseTopic = "local_khimdev";

  List<String> listTopicSubscribed({required String imei}) => [
        topicDeviceStatusAndFirmware(imei: imei),
        topicConfigTemps(imei: imei),
        topicSensorTemps(imei: imei),
        topicButtons(imei: imei),
        topicStatusDevice(imei: imei),
        topicButtons(imei: imei),
        // topicGetInitDevice(imei: imei),
        topicReceiveControlModeDevice(imei: imei),
        topicReceiveModeWaterDischarge(imei: imei),
        topicReceiveSetValue(imei: imei),
        topicReceiveSetService(imei: imei),
        topicReceiveCancelService(imei: imei),
        topicReceiveFingerprint(imei: imei),
        topicListenWarmUp(imei: imei),
        topicReceiveDeleteFingerprint(imei: imei),
      ];

  static String topicDeviceStatusAndFirmware({required String imei}) =>
      "$baseTopic/iot/nailchair/device/lastwill/$imei";

  ///status device nail
  static String topicStatusDevice({required String imei}) =>
      "$baseTopic/iot/nailchair/mobile/status/$imei";

  ///Config temp
  static String topicConfigTemps({required String imei}) =>
      "$baseTopic/iot/nailchair/device/temperature/$imei";

  static String topicSensorTemps({required String imei}) =>
      "$baseTopic/iot/nailchair/mobile/updateTemperature/$imei";

  ///Button
  static String topicButtons({required String imei}) =>
      "$baseTopic/iot/nailchair/mobile/button/$imei";

  static String topicControlButtons({required String imei}) =>
      "$baseTopic/iot/nailchair/mobile/control/$imei";

  ///OTA
  static String topicControlOTA({required String imei}) =>
      "$baseTopic/iot/nailchair/device/ota/$imei";

  // static String topicGetInitDevice({required String imei}) =>
  //     "$baseTopic/iot/nailchair/device/getinfo/$imei";

  // static String topicInitDevice({required String imei}) =>
  //     "$baseTopic/iot/nailchair/device/rgetinfo/$imei";

  ///Mode device
  static String topicControlModeDevice({required String imei}) =>
      "$baseTopic/iot/nailchair/mobile/modeControl/$imei";

  static String topicReceiveControlModeDevice({required String imei}) =>
      "$baseTopic/iot/nailchair/device/receiveModeControl/$imei";

  ///Mode Discharge
  static String topicControlModeDischarge({required String imei}) =>
      "$baseTopic/iot/nailchair/mobile/modeWaterDischarge/$imei";

  static String topicReceiveModeWaterDischarge({required String imei}) =>
      "$baseTopic/iot/nailchair/device/receiveModeWaterDischarge/$imei";

  ///Set Valve
  static String topicSetValve({required String imei}) =>
      "$baseTopic/iot/nailchair/mobile/setValve/$imei";

  static String topicReceiveSetValue({required String imei}) =>
      "$baseTopic/iot/nailchair/device/receiveSetVale/$imei";

  ///Warning
  static String topicReceiveWarning({required String imei}) =>
      "$baseTopic/iot/nailchair/device/warning/$imei";

  ///Service
  static String topicSetService({required String imei}) =>
      "$baseTopic/iot/nailchair/mobile/setService/$imei";

  static String topicReceiveSetService({required String imei}) =>
      "$baseTopic/iot/nailchair/device/receiveSetService/$imei";

  static String topicCancelService({required String imei}) =>
      "$baseTopic/iot/nailchair/mobile/cancelService/$imei";

  static String topicReceiveCancelService({required String imei}) =>
      "$baseTopic/iot/nailchair/device/receiveCancelService/$imei";

  ///Fingerprint
  static String topicStartFingerprint({required String imei}) =>
      "$baseTopic/iot/nailchair/device/addFingerprint/$imei";

  static String topicReceiveFingerprint({required String imei}) =>
      "$baseTopic/iot/nailchair/mobile/receiveAddFingerprint/$imei";

  /// delete fingerprint
  static String topicDeleteFingerprint({required String imei}) =>
      "$baseTopic/iot/nailchair/device/deleteFingerprint/$imei";

  static String topicReceiveDeleteFingerprint({required String imei}) =>
      "$baseTopic/iot/nailchair/device/receiveDeleteFingerprint/$imei";

  ///Warm up
  static String topicListenWarmUp({required String imei}) =>
      "$baseTopic/iot/nailchair/device/warmup/$imei";
}
