enum PayloadType {
  initDevice,
  buttons,
  configTemp,
  sensorTemp,
  waterDischarge,
  receiveSetValve,
  controlModeDevice,
  warning,
  setService,
  cancelService,
  fingerPrint,
  warmUp,
  timeOutValve,
  deleteFingerprint,
  unknown,
}

class PayloadModel {
  final String payload;
  final PayloadType type;

  const PayloadModel({
    required this.payload,
    required this.type,
  });
}
