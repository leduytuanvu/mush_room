import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nail_chair/constant/constant.dart';

import 'package:nail_chair/main.dart';
import 'package:nail_chair/model/PushNotification.dart';


part 'firebase_message_event.dart';

part 'firebase_message_state.dart';

class FirebaseMessageBloc
    extends Bloc<FirebaseMessageEvent, FirebaseMessageState> {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  List<PushNotification> pushNotification = <PushNotification>[];

  FirebaseMessageBloc() : super(FirebaseMessageState()) {
    on<FirebaseMessageInitInfo>(_onFirebaseMessageInitInfo);
    on<FirebaseMessageRequestPermission>(_onFirebaseMessageRequestPermission);
    on<FirebaseMessageGetToken>(_onFirebaseMessageGetToken);
    // on<FirebaseMessageSaveToken>(_onFirebaseMessageSaveToken);
    // on<FirebaseMessageBackground>(_onFirebaseMessageBackground);
    on<FirebaseMessageReceivedNotifications>(
        _onFirebaseMessageReceivedNotifications);
  }

  Future<void> _onFirebaseMessageInitInfo(
      FirebaseMessageInitInfo event, Emitter<FirebaseMessageState> emit) async {
    subscribeToTopic();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print(
          "onMessaging: ${message.notification?.title} / ${message.notification?.body}");
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
          message.notification!.body.toString(),
          htmlFormatContentTitle: true);
      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
        "android_chanel_id",
        "channelName",
        importance: Importance.max,
        styleInformation: bigTextStyleInformation,
        priority: Priority.max,
        playSound: true,
      );
      NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
      );
      if (Platform.isAndroid) {
        await flutterLocalNotificationsPlugin.show(
            0,
            message.notification!.title,
            message.notification!.body,
            notificationDetails,
            payload: message.data['title']);
      }
    });
  }
  Future<void> subscribeToTopic() async {
    await firebaseMessaging.subscribeToTopic('allDevices');

  }
  Future<void> _onFirebaseMessageRequestPermission(
      FirebaseMessageRequestPermission event,
      Emitter<FirebaseMessageState> emit) async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("User granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint("User granted provisional permission");
    } else {
      debugPrint("User declined or has not accepted permission");
    }
  }

  Future<void> _onFirebaseMessageGetToken(
      FirebaseMessageGetToken event, Emitter<FirebaseMessageState> emit) async {
    await firebaseMessaging.getToken().then((token) {
      if (token != null) {
        debugPrint("Token firebase messaging: $token");
        // add(FirebaseMessageSaveToken(token));
      }
    });
  }

  // Future<void> _onFirebaseMessageSaveToken(FirebaseMessageSaveToken event,
  //     Emitter<FirebaseMessageState> emit) async {
  //   await FirebaseFirestore.instance
  //       .collection("UserTokens")
  //       .doc("User2")
  //       .set({"token": event.token});
  // }

  Future<void> _onFirebaseMessageReceivedNotifications(
      FirebaseMessageReceivedNotifications event,
      Emitter<FirebaseMessageState> emit) async {
    pushNotification.add(PushNotification(
      title: event.pushNotification.title,
      body: event.pushNotification.body,
    ));
    emit(state.copyWith(pushNotification: pushNotification));
  }

// Future<void> _onFirebaseMessageBackground(FirebaseMessageBackground event,
//     Emitter<FirebaseMessageState> emit) async {
//   await FirebaseMessaging.instance
//       .setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//   const AndroidInitializationSettings androidInitialize =
//       AndroidInitializationSettings('@mipmap/ic_launcher');
//   const DarwinInitializationSettings iosInitialize =
//       DarwinInitializationSettings();
//   InitializationSettings initializationSettings =
//       const InitializationSettings(
//           android: androidInitialize, iOS: iosInitialize);
//
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//       onDidReceiveNotificationResponse: (notificationResponse) {
//     print("notificationResponse.payload: ${notificationResponse.payload}");
//   });
// }
}
