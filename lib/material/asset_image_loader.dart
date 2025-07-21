import 'package:flutter/material.dart';

class AssetImageLoader extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final FilterQuality filterQuality;
  final Color? color;
  final BlendMode? colorBlendMode;

  const AssetImageLoader({
    Key? key,
    required this.assetPath,
    this.width,
    this.height,
    this.fit,
    this.filterQuality = FilterQuality.low,
    this.color,
    this.colorBlendMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      filterQuality: filterQuality,
      color: color,
      colorBlendMode: colorBlendMode,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return SizedBox(
          width: width,
          height: height,
          child: Center(
            child: SizedBox(
              width: (width ?? 24) * 0.5,
              height: (height ?? 24) * 0.5,
              child: const CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) => SizedBox(
        width: width,
        height: height,
        child: const Icon(Icons.broken_image),
      ),
    );
  }
}
