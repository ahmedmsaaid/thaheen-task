import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:thaheen/core/constants/app_assets.dart';

class CustomLoadingIndicatorWidget extends StatelessWidget {
  final double? size;
  final BoxFit? fit;

  const CustomLoadingIndicatorWidget({
    super.key,
    this.size,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    final dimension = size ?? 56.0;

    return Center(
      child: SizedBox(
        width: dimension,
        height: dimension,
        child: Lottie.asset(
          AppAssets.loadingLottie,
          fit: fit ?? BoxFit.contain,
          animate: true,
          repeat: true,
        ),
      ),
    );
  }
}
