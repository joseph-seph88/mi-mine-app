import 'package:equatable/equatable.dart';
import 'package:mimine/common/entities/post_entity.dart';
import 'package:mimine/common/entities/user_entity.dart';
import 'package:mimine/features/home/domain/entites/notification_entity.dart';

class HomeState extends Equatable {
  final UserEntity? myInfo;
  final List<NotificationEntity> notificationList;
  final List<PostEntity>? myPostList;
  final List<PostEntity>? myBestPostList;

  const HomeState({
    this.myInfo,
    this.notificationList = const [],
    this.myPostList,
    this.myBestPostList,
  });

  HomeState copyWith({
    UserEntity? myInfo,
    List<NotificationEntity>? notificationList,
    List<PostEntity>? myPostList,
    List<PostEntity>? myBestPostList,
  }) {
    return HomeState(
      myInfo: myInfo ?? this.myInfo,
      notificationList: notificationList ?? this.notificationList,
      myPostList: myPostList ?? this.myPostList,
      myBestPostList: myBestPostList ?? this.myBestPostList,
    );
  }

  @override
  List<Object?> get props => [
    myInfo,
    notificationList,
    myPostList,
    myBestPostList,
  ];
}
