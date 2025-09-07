import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimine/features/home/domain/home_usecase.dart';
import 'package:mimine/features/home/presentation/cubits/notification/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final HomeUsecase _homeUsecase;

  NotificationCubit(this._homeUsecase) : super(NotificationState());

  Future<void> loadNotificationData() async {
    final response = await _homeUsecase.getNotificationInfo();
    emit(state.copyWith(notificationList: response));
  }

  Future<void> markAllAsRead() async {
    final notificationIdList = state.notificationList.map((e) => e.id).toList();
    final updatedList = state.notificationList
        .map((notification) => notification.copyWith(isRead: true))
        .toList();
    emit(state.copyWith(notificationList: updatedList));
    await _homeUsecase.markAllAsRead(notificationIdList);
  }

  Future<void> markRead(int notificationId) async {
    final updatedList = state.notificationList
        .map((notification) => notification.id == notificationId
            ? notification.copyWith(isRead: true)
            : notification)
        .toList();
    emit(state.copyWith(notificationList: updatedList));
    await _homeUsecase.markRead(notificationId);
  }
}
