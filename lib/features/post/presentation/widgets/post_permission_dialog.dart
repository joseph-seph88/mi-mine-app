import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mimine/common/enums/permission_status_type.dart';
import 'package:mimine/common/widgets/app_dialog.dart';
import 'package:mimine/features/community/presentation/cubits/community_cubit.dart';
import 'package:mimine/features/community/presentation/cubits/community_state.dart';

abstract class PostPermissionDialog {
  static void show(BuildContext context, CommunityState state) {
    final isPermanentlyDenied =
        state.permissionStatusType ==
        PermissionStatusType.permissionPermanentlyDenied;

    AppDialog.showIconDialog(
      context: context,
      title: isPermanentlyDenied ? '권한이 영구적으로 거부되었습니다' : '권한이 필요합니다',
      message: isPermanentlyDenied
          ? '이미지 업로드를 위해\n설정에서 권한을 허용해주세요.'
          : '이미지 업로드를 위해\n카메라 및 갤러리 접근 권한이 필요합니다.',
      actions: [
        AppDialog.buildTextButton(text: '나중에', onPressed: () => context.pop()),
        const SizedBox(width: 12),
        AppDialog.buildElevatedButton(
          text: isPermanentlyDenied ? '설정으로 이동' : '권한 요청',
          onPressed: () async {
            context.pop();
            if (isPermanentlyDenied) {
              await context.read<CommunityCubit>().openPermissionAppSettings(
                state.requiredPermissionList.first,
              );
            } else {
              await context.read<CommunityCubit>().checkRequestPermission();
            }
          },
        ),
      ],
    );
  }
}
