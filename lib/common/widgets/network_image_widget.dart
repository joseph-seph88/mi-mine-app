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
