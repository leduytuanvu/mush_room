import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mush_room/core/blocs/app_bloc/app_bloc.dart';
import 'package:mush_room/core/blocs/mqtt/mqtt_event.dart';
import 'package:mush_room/core/constant/mqtt/topic.dart';
import 'package:mush_room/core/models/mqtt/payload.dart';
import 'package:mush_room/core/utils/app_logger.dart';

class MqttPublishFunc {
  MqttPublishFunc._privateConstructor();

  // Private static instance variable
  static final MqttPublishFunc _instance =
      MqttPublishFunc._privateConstructor();

  // Public static getter to access the instance
  static MqttPublishFunc get instance => _instance;

  // void getFirmWare() {
  //   AppBloc.mqttBloc.add(MqttPublish(
  //       MqttConstantTopic.topicGetInitDevice(imei: AppBloc.mqttBloc.currentImei),
  //       json.encode({"info": "nailchair"})));
  // }

  Timer? timer;
  int timeOut = 10;
  ResultMqtt receiveData = const ResultMqtt(topic: "", payload: "");
  Completer<PayloadModel>? completer;

  bool enable() {
    if (timer != null && timer!.isActive) {
      return true;
    } else {
      return false;
    }
  }

  void startTimeOut() {
    if (!enable()) {
      timer = Timer.periodic(Duration(seconds: timeOut), (value) {
        completer?.complete(PayloadModel(
            payload: json.encode(
              {"status": "timeOut"},
            ),
            type: PayloadType.timeOut));
        completer = null;
        endTimeOut();
      });
    }
  }

  void endTimeOut() {
    if (enable()) {
      timer!.cancel();
      timer = null;
      AppBloc.mqttBloc.add(
        ReceiveDataEvent(
          payload: PayloadModel(
              payload: json.encode(
                {"status": "timeOut"},
              ),
              type: PayloadType.timeOut),
        ),
      );
    }
  }

  void startListenMqtt() {
    AppBloc.mqttBloc.listenMqtt.stream.listen(
      (result) {
        if (result.topic == receiveData.topic) {
          endTimeOut();
          completer = null;
        }
      },
    );
  }

  void _formatPublish({
    required String topicSend,
    required String receiveTopic,
    required String payload,
    required Completer<PayloadModel> completer,
  }) {
    if (!enable()) {
      startTimeOut();
      this.completer = completer;
      receiveData = ResultMqtt(topic: receiveTopic, payload: "");
      AppBloc.mqttBloc.add(
        MqttPublish(
          topicSend,
          payload,
        ),
      );
    }
  }

  Future<PayloadModel> sendTest() {
    Completer<PayloadModel> completer = Completer<PayloadModel>();
    _formatPublish(
      topicSend: MqttConstantTopic.topicTest(),
      receiveTopic: MqttConstantTopic.topicReceiveTest(),
      completer: completer,
      payload: json.encode(
        {"test": 0},
      ),
    );
    return completer.future;
  }
}
