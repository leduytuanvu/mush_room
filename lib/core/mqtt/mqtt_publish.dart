import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:nail_chair/model/mode_discharge_model.dart';
import 'package:nail_chair/model/service_item_model.dart';
import 'package:nail_chair/model/valve_model.dart';

import '../../bloc/app_bloc/app_bloc.dart';
import '../../bloc/mqtt/mqtt_event.dart';
import '../../constant/mqtt/constant.dart';
import '../../constant/mqtt/topic.dart';

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
  int timeOut = 5;
  Timer? timer;

  bool enable() {
    if (timer != null && timer!.isActive) {
      return true;
    } else {
      return false;
    }
  }

  void _countDown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeOut > 0) {
        timeOut--;
      } else {
        timer.cancel();
      }
    });
  }

  void controlModeDevice(int value, String imei) {
    AppBloc.mqttBloc.add(MqttPublish(
      MqttConstantTopic.topicControlModeDevice(imei: imei),
      json.encode(
        {"mode": value},
      ),
    ));
  }

  void controlButton(int button) {
    AppBloc.mqttBloc.add(
      MqttPublish(
        MqttConstantTopic.topicControlButtons(
            imei: AppBloc.mqttBloc.currentImei),
        json.encode(
          {"button": Buttons.buttonToMqtt(button)},
        ),
      ),
    );
  }

  void controlModeWaterDischarge(ModeDischargeModel modeDischargeModel) {
    AppBloc.mqttBloc.add(
      MqttPublish(
          MqttConstantTopic.topicControlModeDischarge(
              imei: AppBloc.mqttBloc.currentImei),
          json.encode(modeDischargeModel.toJson())),
    );
  }

  void setService(ServiceItemModel serviceItemModel) {
    AppBloc.mqttBloc.add(
      MqttPublish(
          MqttConstantTopic.topicSetService(imei: AppBloc.mqttBloc.currentImei),
          json.encode({"serviceTimeout": serviceItemModel.timeout})),
    );
  }

  void setCancelService() {
    AppBloc.mqttBloc.add(
      MqttPublish(
          MqttConstantTopic.topicCancelService(
              imei: AppBloc.mqttBloc.currentImei),
          json.encode({
            "service": 0 /* Nhận lệnh này thì cancel service hiện tại */
          })),
    );
  }

  void controlValve(
      {required int valveHot,
      required int valveCool,
      required int valveDrain}) {
    ValveModel valveModel = ValveModel(
        valveHot: valveHot, valveDrain: valveDrain, valveCool: valveCool);
    AppBloc.mqttBloc.add(
      MqttPublish(
          MqttConstantTopic.topicSetValve(imei: AppBloc.mqttBloc.currentImei),
          json.encode(valveModel.toJson())),
    );
  }

  void startFingerprint() {
    AppBloc.mqttBloc.add(
      MqttPublish(
        MqttConstantTopic.topicStartFingerprint(
            imei: AppBloc.mqttBloc.currentImei),
        json.encode(
          {"create": 1},
        ),
      ),
    );
  }

  void deleteFingerprint({required int fingerId}){
    AppBloc.mqttBloc.add(
      MqttPublish(
        MqttConstantTopic.topicDeleteFingerprint(
            imei: AppBloc.mqttBloc.currentImei),
        json.encode(
          {
            "fingerId": fingerId
          },
        ),
      ),
    );
  }
}
