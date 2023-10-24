import 'package:equatable/equatable.dart';
import 'package:mush_room/core/models/mqtt/payload.dart';

import 'mqtt_state.dart';

class MqttEvent extends Equatable {
  const MqttEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MqttConnect extends MqttEvent {
  final bool refreshDataDevice;
  const MqttConnect({this.refreshDataDevice = true});
}

class MqttPublish extends MqttEvent {
  // final String topic;
  final String data;
  final String topic;
  const MqttPublish(
    this.topic,
    this.data,
  );
}

class MqttDisconnect extends MqttEvent {}

class ConnectStateChange extends MqttEvent {}

class MqttOnConnected extends MqttEvent {}

class MqttOnDisconnected extends MqttEvent {}

class MqttOnSubscribed extends MqttEvent {
  final String topic;

  const MqttOnSubscribed(this.topic);
}

class MqttSubscribed extends MqttEvent {}

class MqttOnSubscribeFail extends MqttEvent {
  final String topic;

  const MqttOnSubscribeFail(this.topic);
}

class MqttOnUnsubscribed extends MqttEvent {
  final String topic;

  const MqttOnUnsubscribed(this.topic);
}

class MqttOnPong extends MqttEvent {}

class GetDataFromServer extends MqttEvent {
  final String data;

  const GetDataFromServer(this.data);
}

class DeviceNotify extends MqttEvent {
  final DeviceStatus deviceStatus;

  const DeviceNotify({
    required this.deviceStatus,
  });
}

class UpdateTemp extends MqttEvent {
  final int temp1;
  final int temp2;

  const UpdateTemp({required this.temp1, required this.temp2});
}

class UpdateImei extends MqttEvent {
  final String imei;

  const UpdateImei({required this.imei});
}

class MqttUnsubscribed extends MqttEvent {}

class ReceiveDataEvent extends MqttEvent {
  final PayloadModel payload;
  const ReceiveDataEvent({required this.payload});
}
