import 'package:flutter/material.dart';
import 'package:mimine/common/constants/image_path.dart';

class NetworkImageWidget {
  static Widget networkImage({
    String? imageUrl,
    double? width = 60,
    double? height = 60,
    double? iconSize = 30,
    BoxFit? fit = BoxFit.cover,
  }) {
    return imageUrl != null && imageUrl.isNotEmpty
        ? Image.network(
            imageUrl,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: (context, error, stackTrace) {
              // 네트워크 에러 시 기본 이미지 표시
              return Image.asset(
                ImagePath.defaultProfile,
                width: width,
                height: height,
                fit: fit,
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              // 로딩 중일 때 표시할 위젯
              return Container(
                width: width,
                height: height,
                color: Colors.grey[200],
                child: const Center(child: CircularProgressIndicator()),
              );
            },
          )
        : Image.asset(
            ImagePath.defaultProfile,
            width: width,
            height: height,
            fit: fit,
          );
  }

  static ImageProvider<Object>? getNetworkImageProvider(String? imageUrl) {
    return imageUrl != null && imageUrl.isNotEmpty
        ? NetworkImage(imageUrl)
        : AssetImage(ImagePath.defaultProfile);
  }
}
