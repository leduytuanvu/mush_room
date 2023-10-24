part of 'firebase_message_bloc.dart';

@immutable
class FirebaseMessageState extends Equatable {
  final List<PushNotification> pushNotification;

  final int totalNotifications;

  FirebaseMessageState({
    this.pushNotification = const <PushNotification>[],
    this.totalNotifications = 0,
  });
  FirebaseMessageState copyWith({
    List<PushNotification>? pushNotification,
    int? totalNotifications,
  }) {
    return FirebaseMessageState(
      pushNotification: pushNotification ?? this.pushNotification,
      totalNotifications: totalNotifications ?? this.totalNotifications,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
