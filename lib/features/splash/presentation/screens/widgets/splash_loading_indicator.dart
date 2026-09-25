import 'package:flutter/material.dart';
import 'package:thaheen/core/widgets/custom_loading_indicator_widget.dart';

class SplashLoadingIndicator extends StatelessWidget {
  const SplashLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomLoadingIndicatorWidget(size: 40);
  }
}
