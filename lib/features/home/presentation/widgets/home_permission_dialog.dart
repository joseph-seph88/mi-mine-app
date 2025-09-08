import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mimine/common/widgets/app_dialog.dart';
import 'package:mimine/features/home/presentation/cubits/home/home_cubit.dart';
import 'package:mimine/features/home/presentation/cubits/home/home_state.dart';

class HomePermissionDialog {
  static void show(BuildContext context, HomeState state) {
    AppDialog.showIconDialog(
      context: context,
      title: '권한이 필요합니다',
      message: '원활한 서비스 이용을 위해\n설정에서 권한을 허용해주세요.',
      actions: [
        AppDialog.buildTextButton(text: '나중에', onPressed: () => context.pop()),
        const SizedBox(width: 12),
        AppDialog.buildElevatedButton(
          text: '설정으로 이동',
          onPressed: () async {
            context.pop();
            await context.read<HomeCubit>().openPermissionAppSettings(
              state.requiredPermissionList.first,
            );
          },
        ),
      ],
    );
  }
}
