import 'package:equatable/equatable.dart';
import 'package:mimine/features/home/domain/entites/notification_entity.dart';

class NotificationState extends Equatable {
  final List<NotificationEntity> notificationList;

  const NotificationState({
    this.notificationList = const [],
  });

  NotificationState copyWith({
    List<NotificationEntity>? notificationList,
  }) {
    return NotificationState(
      notificationList: notificationList ?? this.notificationList,
    );
  }

  @override
  List<Object?> get props => [notificationList];
}