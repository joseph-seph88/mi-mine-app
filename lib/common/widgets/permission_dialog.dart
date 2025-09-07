import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mimine/common/widgets/app_dialog.dart';
import 'package:mimine/features/shell/presentation/cubits/shell_cubit.dart';
import 'package:mimine/features/shell/presentation/cubits/shell_state.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionDialog {
  static void show(BuildContext context, ShellState state) {
    AppDialog.showIconDialog(
      context: context,
      title: '권한이 필요합니다',
      message: '원활한 서비스 이용을 위해\n설정에서 권한을 허용해주세요.',
      actions: [
        AppDialog.buildTextButton(
          text: '나중에',
          onPressed: () => context.pop(),
        ),
        const SizedBox(width: 12),
        AppDialog.buildElevatedButton(
          text: '설정으로 이동',
          onPressed: () async {
            context.pop();
            await context.read<ShellCubit>().openPermissionAppSettings(
                state.permanentlyDeniedPermissions?.first ??
                    Permission.location);
          },
        ),
      ],
    );
  }
}
