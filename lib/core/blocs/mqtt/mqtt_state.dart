import 'package:equatable/equatable.dart';


import '../../model/payload.dart';

enum MqttStatus { connected, connecting, disconnected, unknown }

enum DeviceStatus { connected, disconnected }

class MqttState extends Equatable {
  final MqttStatus mqttStatus;
  final DeviceStatus deviceStatus;
  final bool sendDataToServer;
  final PayloadModel payload;
  final String currentImei;

  const MqttState({
    this.mqttStatus = MqttStatus.unknown,
    this.deviceStatus = DeviceStatus.disconnected,
    this.sendDataToServer = false,
    this.payload = const PayloadModel(payload: "", type: PayloadType.unknown),
    this.currentImei = "",
  });

  @override
  List<Object> get props => [
        mqttStatus,
        sendDataToServer,
        deviceStatus,
        currentImei,
        payload,
      ];

  MqttState copyWith({
    MqttStatus? mqttStatus,
    DeviceStatus? deviceStatus,
    bool? sendDataToServer,
    String? currentImei,
    PayloadModel? payload,
  }) {
    return MqttState(
      mqttStatus: mqttStatus ?? this.mqttStatus,
      deviceStatus: deviceStatus ?? this.deviceStatus,
      sendDataToServer: sendDataToServer ?? this.sendDataToServer,
      currentImei: currentImei ?? this.currentImei,
      payload: payload ?? this.payload,
    );
  }
}
