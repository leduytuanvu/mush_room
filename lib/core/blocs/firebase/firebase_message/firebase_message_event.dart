part of 'firebase_message_bloc.dart';

class FirebaseMessageEvent extends Equatable {
  const FirebaseMessageEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FirebaseMessageInitInfo extends FirebaseMessageEvent {}

class FirebaseMessageRequestPermission extends FirebaseMessageEvent {}

class FirebaseMessageBackground extends FirebaseMessageEvent {}

class FirebaseMessageGetToken extends FirebaseMessageEvent {}

class FirebaseMessageSaveToken extends FirebaseMessageEvent {
  final String token;

  const FirebaseMessageSaveToken(this.token);
}

class FirebaseMessageReceivedNotifications extends FirebaseMessageEvent {
  final PushNotification pushNotification;
  FirebaseMessageReceivedNotifications(this.pushNotification);
}
