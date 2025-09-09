import 'package:equatable/equatable.dart';
import 'package:mimine/common/entities/user_entity.dart';
import 'package:mimine/features/home/domain/entites/notification_entity.dart';

class HomeState extends Equatable {
  final UserEntity? myInfo;
  final List<NotificationEntity> notificationList;

  const HomeState({this.myInfo, this.notificationList = const []});

  HomeState copyWith({
    UserEntity? myInfo,
    List<NotificationEntity>? notificationList,
  }) {
    return HomeState(
      myInfo: myInfo ?? this.myInfo,
      notificationList: notificationList ?? this.notificationList,
    );
  }

  @override
  List<Object?> get props => [myInfo, notificationList];
}
