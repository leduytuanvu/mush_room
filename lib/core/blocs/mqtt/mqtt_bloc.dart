import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../constant/constant.dart';
import '../../constant/mqtt/topic.dart';
import '../../model/payload.dart';
import '../app_bloc/app_bloc.dart';
import '../network/network_bloc.dart';
import 'mqtt_event.dart';
import 'mqtt_state.dart';

class MqttBloc extends Bloc<MqttEvent, MqttState> {
  late MqttServerClient client;
  String dataFromServer = "";
  StreamController<DeviceStatus> connectionController =
      StreamController<DeviceStatus>();
  Timer? timerConnect;
  String currentImei = "";

  DeviceStatus getDeviceStatus(String payload) {
    if (jsonDecode(payload)["status"] != null) {
      switch (jsonDecode(payload)["status"]) {
        case "ONLINE":
          add(const DeviceNotify(deviceStatus: DeviceStatus.connected));
          return DeviceStatus.connected;
        case "OFFLINE":
          add(const DeviceNotify(deviceStatus: DeviceStatus.disconnected));
          return DeviceStatus.disconnected;
        default:
          add(const DeviceNotify(deviceStatus: DeviceStatus.disconnected));
          return DeviceStatus.disconnected;
      }
    } else {
      add(const DeviceNotify(deviceStatus: DeviceStatus.disconnected));
      return DeviceStatus.disconnected;
    }
  }

  // void Function()? onConnect;
  MqttBloc() : super(const MqttState()) {
    on<MqttConnect>(_onMqttConnect);
    on<MqttPublish>(_onMqttPublish);
    on<MqttDisconnect>(_onMqttDisconnect);
    on<ConnectStateChange>(_onConnectStateChange);
    on<MqttOnSubscribed>(_onMqttOnSubscribed);
    on<MqttOnSubscribeFail>(_onMqttOnSubscribeFail);
    on<MqttOnUnsubscribed>(_onMqttOnUnsubscribed);
    on<MqttOnPong>(_onMqttOnPong);
    on<ReceiveDataEvent>(_onReceiveDataEvent);
    on<MqttSubscribed>(_onMqttSubscribed);
    on<MqttUnsubscribed>(_onMqttUnsubscribed);
    on<DeviceNotify>(_onDeviceNotify);

    on<UpdateImei>(_onUpdateImei);
  }

  Future<void> _onMqttConnect(
      MqttConnect event, Emitter<MqttState> emit) async {
    if (state.mqttStatus != MqttStatus.connected &&
        state.mqttStatus != MqttStatus.connecting &&
        AppBloc.networkBloc.state.networkStatus == ConnectivityStatus.online) {
      client = MqttServerClient(MqttConstant.iotServerCertificate, "");
      client.logging(on: false);
      client.keepAlivePeriod = MqttConstant.alivePeriod;
      client.port = MqttConstant.portCertificate;
      client.onConnected = onConnected;
      client.onDisconnected = onDisconnected;
      client.onUnsubscribed = onUnsubscribed;
      client.onSubscribed = onSubscribed;
      client.onSubscribeFail = onSubscribeFail;
      client.pongCallback = pong;
      client.onBadCertificate = (dynamic a) => true;

      ///for connect certificate
      client.setProtocolV311();
      String clientId =
          "${DateTime.now()}-${Random().nextInt(10000)}-${Random().nextInt(10000)}-${Random().nextInt(10000)}-${Random().nextInt(10000)}";

      // final connMessage = MqttConnectMessage()
      //     .withClientIdentifier("Client_$clientId")
      //     .authenticateAs(
      //       MqttConstant.username,
      //       MqttConstant.password,
      //     )
      //     .startClean()
      //     .withWillQos(MqttQos.atMostOnce);
      // client.connectionMessage = connMessage;

      final context = SecurityContext.defaultContext;
      final clientAuthorities =
          await rootBundle.load('assets/mqtt/AmazonRootCA1.pem');
      context.setClientAuthoritiesBytes(clientAuthorities.buffer.asUint8List());

      final certificateChain =
          await rootBundle.load('assets/mqtt/bea8-certificate.pem.crt');
      context.useCertificateChainBytes(certificateChain.buffer.asUint8List());

      final privateKey =
          await rootBundle.load('assets/mqtt/bea8-private.pem.key');
      context.usePrivateKeyBytes(privateKey.buffer.asUint8List());

      client.secure = true;
      client.securityContext = context;

      final connMess = MqttConnectMessage()
          .withClientIdentifier("Client_$clientId")
          .startClean();
      client.connectionMessage = connMess;
      try {
        debugPrint("Start mqtt Connect");
        await client.connect();
      } on NoConnectionException catch (e) {
        debugPrint(" mqtt Connect error");
        // Raised by the client when connection fails.
        debugPrint('EXAMPLE::client exception - $e');

        client.disconnect();
      } on SocketException catch (e) {
        // Raised by the socket layer
        debugPrint(" mqtt Connect error");
        debugPrint('EXAMPLE::socket exception connecting to - ${e.message}');
        if (e.message.contains("Failed host lookup")) {
        } else {
          client.disconnect();
        }
      }

      client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
        final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
        final String payload =
            MqttPublishPayload.bytesToStringAsString(message.payload.message);
        debugPrint("topic: ${c[0].topic}\ndata: $payload");
        if (c[0].topic ==
                MqttConstantTopic.topicDeviceStatusAndFirmware(
                    imei: state.currentImei) &&
            payload != "turn off") {
          getDeviceStatus(payload);
        }else
        if (c[0].topic ==
            MqttConstantTopic.topicButtons(
              imei: state.currentImei,
            )) {
          add(
            ReceiveDataEvent(
              payload: PayloadModel(
                payload: payload,
                type: PayloadType.buttons,
              ),
            ),
          );
        } else if (c[0].topic ==
            MqttConstantTopic.topicConfigTemps(imei: state.currentImei)) {
          add(ReceiveDataEvent(
              payload: PayloadModel(
                  payload: payload, type: PayloadType.configTemp)));
        } else if (c[0].topic ==
            MqttConstantTopic.topicSensorTemps(imei: state.currentImei)) {
          add(ReceiveDataEvent(
              payload: PayloadModel(
                  payload: payload, type: PayloadType.sensorTemp)));
        }
        // else if (c[0].topic ==
        //     MqttConstantTopic.topicInitDevice(imei: state.currentImei)) {
        //   debugPrint("topic: ${c[0].topic}, data: $payload");
        //   add(ReceiveDataEvent(
        //       payload: PayloadModel(
        //           payload: payload, type: PayloadType.initDevice)));
        // }
        else if (c[0].topic ==
            MqttConstantTopic.topicReceiveControlModeDevice(
                imei: state.currentImei)) {
          debugPrint("topic: ${c[0].topic}, data: $payload");
          add(ReceiveDataEvent(
              payload: PayloadModel(
                  payload: payload, type: PayloadType.controlModeDevice)));
        } else if (c[0].topic ==
            MqttConstantTopic.topicReceiveModeWaterDischarge(
                imei: state.currentImei)) {
          add(ReceiveDataEvent(
              payload: PayloadModel(
                  payload: payload, type: PayloadType.waterDischarge)));
        } else if (c[0].topic ==
            MqttConstantTopic.topicReceiveSetValue(imei: state.currentImei)) {
          add(ReceiveDataEvent(
              payload: PayloadModel(
                  payload: payload, type: PayloadType.receiveSetValve)));
        } else if (c[0].topic ==
            MqttConstantTopic.topicReceiveWarning(imei: state.currentImei)) {
          add(ReceiveDataEvent(
              payload:
                  PayloadModel(payload: payload, type: PayloadType.warning)));
        }
        else if (c[0].topic ==
            MqttConstantTopic.topicReceiveSetService(imei: state.currentImei)) {
          add(ReceiveDataEvent(
              payload:
              PayloadModel(payload: payload, type: PayloadType.setService)));
        }
          else if (c[0].topic ==
            MqttConstantTopic.topicReceiveCancelService(imei: state.currentImei)) {

          add(ReceiveDataEvent(
              payload:
              PayloadModel(payload: payload, type: PayloadType.cancelService)));
        }
        // else if (c[0].topic ==
        //     MqttConstantTopic.topicReceiveTimeOutAll(imei: state.currentImei)) {
        //   add(ReceiveDataEvent(
        //       payload: PayloadModel(
        //           payload: payload, type: PayloadType.timeOutAll)));
        // }
        else
        if (c[0].topic ==
            MqttConstantTopic.topicListenWarmUp(
              imei: state.currentImei,
            )) {

          add(
            ReceiveDataEvent(
              payload: PayloadModel(
                payload: payload,
                type: PayloadType.warmUp,
              ),
            ),
          );
        }
        ///for beep
        // else if (c[0].topic ==
        //     MqttConstantTopic.topicControlButtons(imei: state.currentImei)) {
        //   SoundService.instance.playTapDownSound();
        // }
        else if (c[0].topic ==
            MqttConstantTopic.topicReceiveFingerprint(imei: state.currentImei)) {
          add(
            ReceiveDataEvent(
              payload: PayloadModel(
                payload: payload,
                type: PayloadType.fingerPrint,
              ),
            ),
          );
        }else if (c[0].topic ==
            MqttConstantTopic.topicReceiveDeleteFingerprint(imei: state.currentImei)) {
          add(
            ReceiveDataEvent(
              payload: PayloadModel(
                payload: payload,
                type: PayloadType.deleteFingerprint,
              ),
            ),
          );
        }
      });
    }
  }

  void _onMqttPublish(MqttPublish event, Emitter<MqttState> emit) async {
    // Publish to a topic of your choice after a slight delay, AWS seems to need this
    // await MqttUtilities.asyncSleep(1);
    final builder = MqttClientPayloadBuilder();
    builder.addString(event.data);
    // Important: AWS IoT Core can only handle QOS of 0 or 1. QOS 2 (exactlyOnce) will fail!
    client.publishMessage(event.topic, MqttQos.atLeastOnce, builder.payload!);

    debugPrint("publish topic:${event.topic}, data: ${event.data}");
  }

  void _onMqttDisconnect(MqttDisconnect event, Emitter<MqttState> emit) {
    if (state.mqttStatus == MqttStatus.connected) {
      client.disconnect();
    }
  }

  void onConnected() {
    add(ConnectStateChange());
  }

// unconnected
  void onDisconnected() {
    add(ConnectStateChange());
    debugPrint('OnDisconnected client callback - Client disconnection');

    if (client.connectionStatus!.disconnectionOrigin ==
        MqttDisconnectionOrigin.solicited) {
      debugPrint('OnDisconnected callback is solicited, this is correct');
    } else {
      Future.delayed((const Duration(seconds: 3)), () {
        debugPrint(
            "MqttReConnect 1 networkStatus: ${AppBloc.networkBloc.state.networkStatus}, mqttStatus: ${state.mqttStatus}");
        if (AppBloc.networkBloc.state.networkStatus ==
                ConnectivityStatus.online &&
            state.mqttStatus != MqttStatus.connected) {
          Future.delayed((const Duration(seconds: 3)), () {
            var counter = 3;
            timerConnect = Timer.periodic(const Duration(seconds: 3), (timer) {
              counter--;
              debugPrint("MqttReConnect 2");
              add(const MqttConnect());
              if (counter == 0 || state.mqttStatus == MqttStatus.connected) {
                timerConnect?.cancel();
              }
            });
          });
        }
      });
    }
  }

// subscribe to topic succeeded
  void onSubscribed(String topic) {
    add(MqttOnSubscribed(topic));
  }

// subscribe to topic failed
  void onSubscribeFail(String topic) {
    add(MqttOnSubscribeFail(topic));
  }

// unsubscribe succeeded
  void onUnsubscribed(String? topic) {
    add(MqttOnUnsubscribed(topic!));
  }

// PING response received
  void pong() {
    debugPrint('Ping response client callback invoked');
  }

  void _onMqttOnSubscribed(MqttOnSubscribed event, Emitter<MqttState> emit) {
    debugPrint('Subscribed topic: ${event.topic}');
  }

  void _onMqttOnSubscribeFail(
      MqttOnSubscribeFail event, Emitter<MqttState> emit) {
    debugPrint('Failed to subscribe ${event.topic}');
  }

  void _onMqttOnUnsubscribed(
      MqttOnUnsubscribed event, Emitter<MqttState> emit) {
    debugPrint('Unsubscribed topic: ${event.topic}');
  }

  void _onMqttOnPong(MqttOnPong event, Emitter<MqttState> emit) {}

  void _onConnectStateChange(
      ConnectStateChange event, Emitter<MqttState> emit) {
    switch (client.connectionStatus!.state) {
      case MqttConnectionState.disconnecting:
        emit(state.copyWith(mqttStatus: MqttStatus.disconnected));
        break;
      case MqttConnectionState.disconnected:
        debugPrint('Server mqtt disconnected');

        emit(state.copyWith(mqttStatus: MqttStatus.disconnected));

        break;
      case MqttConnectionState.connecting:
        emit(state.copyWith(mqttStatus: MqttStatus.connecting));

        break;
      case MqttConnectionState.connected:
        debugPrint('Connected server mqtt successful');
        emit(state.copyWith(mqttStatus: MqttStatus.connected));
        if (timerConnect?.isActive ?? false) {
          timerConnect?.cancel();
        }
        add(MqttSubscribed());

        break;
      case MqttConnectionState.faulted:
        emit(state.copyWith(mqttStatus: MqttStatus.disconnected));
        break;
    }
  }

  void _onMqttSubscribed(MqttSubscribed event, Emitter<MqttState> emit) {
    if (state.currentImei != "" && state.mqttStatus == MqttStatus.connected) {
      List<String> listTopic = MqttConstantTopic.instance
          .listTopicSubscribed(imei: state.currentImei);
      for (String topic in listTopic) {
        client.subscribe(topic, MqttQos.atLeastOnce);
      }
      // client.subscribe(
      //     MqttConstantTopic.topicInitDevice(imei: state.currentImei),
      //     MqttQos.atLeastOnce);
      // client.subscribe(
      //     MqttConstantTopic.topicDeviceStatusAndFirmware(
      //         imei: state.currentImei),
      //     MqttQos.atLeastOnce);
      // client.subscribe(
      //     MqttConstantTopic.topicConfigTemps(imei: state.currentImei),
      //     MqttQos.atLeastOnce);
      // client.subscribe(
      //     MqttConstantTopic.topicSensorTemps(imei: state.currentImei),
      //     MqttQos.atLeastOnce);
      //
      // ///for beep
      // // client.subscribe(
      // //     MqttConstantTopic.topicControlButtons(imei: state.currentImei),
      // //     MqttQos.atLeastOnce);
      //
      // client.subscribe(MqttConstantTopic.topicButtons(imei: state.currentImei),
      //     MqttQos.atLeastOnce);
      // client.subscribe(
      //     MqttConstantTopic.topicReceiveControlModeDevice(
      //         imei: state.currentImei),
      //     MqttQos.atLeastOnce);
      // client.subscribe(
      //     MqttConstantTopic.topicReceiveModeWaterDischarge(
      //         imei: state.currentImei),
      //     MqttQos.atLeastOnce);
      // client.subscribe(
      //     MqttConstantTopic.topicReceiveSetValue(imei: state.currentImei),
      //     MqttQos.atLeastOnce);
      // client.subscribe(
      //     MqttConstantTopic.topicReceiveWarning(imei: state.currentImei),
      //     MqttQos.atLeastOnce);
      // // client.subscribe(
      // //     MqttConstantTopic.topicReceiveSetService(imei: state.currentImei),
      // //     MqttQos.atLeastOnce);
      // // client.subscribe(
      // //     MqttConstantTopic.topicReceiveCancelService(imei: state.currentImei),
      // //     MqttQos.atLeastOnce);
      // client.subscribe(
      //     MqttConstantTopic.topicReceiveTimeOutAll(imei: state.currentImei),
      //     MqttQos.atLeastOnce);
    }
  }

  void _onDeviceNotify(DeviceNotify event, Emitter<MqttState> emit) {
    emit(state.copyWith(deviceStatus: event.deviceStatus));
  }

  // void _onUpdateTemp(UpdateTemp event, Emitter<MqttState> emit) {
  //   emit(state.copyWith(temp1: event.temp1, temp2: event.temp2));
  // }

  void _onUpdateImei(UpdateImei event, Emitter<MqttState> emit) {
    currentImei = event.imei;

    emit(state.copyWith(currentImei: currentImei));
    debugPrint("_onUpdateImei ${state.currentImei}");
  }

  void _onMqttUnsubscribed(MqttUnsubscribed event, Emitter<MqttState> emit) {
    if (state.mqttStatus == MqttStatus.connected && state.currentImei != "") {
      List<String> listTopic = MqttConstantTopic.instance
          .listTopicSubscribed(imei: state.currentImei);
      for (String topic in listTopic) {
        client.unsubscribe(
          topic,
        );
      }
      // client.unsubscribe(
      //   MqttConstantTopic.topicDeviceStatusAndFirmware(imei: state.currentImei),
      // );
      // client.unsubscribe(
      //   MqttConstantTopic.topicConfigTemps(imei: state.currentImei),
      // );
      // client.unsubscribe(
      //   MqttConstantTopic.topicSensorTemps(imei: state.currentImei),
      // );
      //
      // ///for beep
      // // client.unsubscribe(
      // //   MqttConstantTopic.topicControlButtons(imei: state.currentImei),
      // // );
      // client.unsubscribe(
      //   MqttConstantTopic.topicButtons(imei: state.currentImei),
      // );
      // client.unsubscribe(
      //   MqttConstantTopic.topicReceiveControlModeDevice(
      //       imei: state.currentImei),
      // );
      // client.unsubscribe(
      //   MqttConstantTopic.topicReceiveModeWaterDischarge(
      //       imei: state.currentImei),
      // );
      // client.unsubscribe(
      //   MqttConstantTopic.topicReceiveSetValue(imei: state.currentImei),
      // );
      // client.unsubscribe(
      //   MqttConstantTopic.topicReceiveWarning(imei: state.currentImei),
      // );
      // // client.unsubscribe(
      // //   MqttConstantTopic.topicReceiveSetService(imei: state.currentImei),
      // // );
      // // client.unsubscribe(
      // //   MqttConstantTopic.topicReceiveCancelService(imei: state.currentImei),
      // // );
      // client.unsubscribe(
      //   MqttConstantTopic.topicReceiveTimeOutAll(imei: state.currentImei),
      // );
    }
  }

  void _onReceiveDataEvent(ReceiveDataEvent event, Emitter<MqttState> emit) {
    emit(state.copyWith(payload: event.payload));
  }
}
