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
  timeOut,
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

class ResultMqtt {
  final String topic;
  final String payload;


  const ResultMqtt({
    required this.topic,
    required this.payload,

  });
}