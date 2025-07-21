import 'package:flutter/material.dart';

class NetworkImageLoader extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;

  const NetworkImageLoader({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.fit,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      color: color,
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
