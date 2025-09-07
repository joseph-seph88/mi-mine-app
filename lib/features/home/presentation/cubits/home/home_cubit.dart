import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimine/features/home/domain/home_usecase.dart';
import 'package:mimine/features/home/presentation/cubits/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeUsecase _homeUsecase;

  HomeCubit(this._homeUsecase) : super(HomeState());

  Future<void> loadHomeData() async {
    final response = await _homeUsecase.getMyInfo();

    emit(state.copyWith(homeData: response));
  }

  Future<void> createPost(
      String title, String description, String imageUrl) async {
    await _homeUsecase.createPost(title, description, imageUrl);

    final currentAllContents = state.homeData?.allContents ?? [];
    final updatedAllContents = [
      ...currentAllContents,
      {
        'imageUrl': imageUrl,
        'title': title,
        'description': description,
      }
    ];

    emit(state.copyWith(
      homeData: state.homeData?.copyWith(allContents: updatedAllContents),
    ));
  }

  Future<void> updatePost(String postId, String title, String description, String imageUrl) async {
    await _homeUsecase.updatePost(postId, title, description, imageUrl);

    final updatedAllContents = state.homeData?.allContents?.map((e) => e['id'] == postId ? {
      'imageUrl': imageUrl,
      'title': title,
      'description': description,
    } : e).toList();

    emit(state.copyWith(homeData: state.homeData?.copyWith(allContents: updatedAllContents)));
  }

  Future<void> deletePost(String postId) async {
    await _homeUsecase.deletePost(postId);

    final updatedAllContents = state.homeData?.allContents?.where((e) => e['id'] != postId).toList();
    emit(state.copyWith(homeData: state.homeData?.copyWith(allContents: updatedAllContents)));
  }
}
