import 'package:flutter/material.dart';
import 'network_image_loader.dart';

class NetworkIcon extends StatelessWidget {
  final String url;
  final double size;
  final Color? color;

  const NetworkIcon({
    Key? key,
    required this.url,
    required this.size,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NetworkImageLoader(
      url: url,
      width: size,
      height: size,
      fit: BoxFit.contain,
      color: color,
    );
  }
}
