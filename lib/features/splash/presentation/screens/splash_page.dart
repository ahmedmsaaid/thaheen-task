import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thaheen/core/router/app_router.dart';
import 'package:thaheen/core/theme/app_colors.dart';
import 'package:thaheen/features/splash/presentation/screens/widgets/splash_loading_indicator.dart';
import 'package:thaheen/features/splash/presentation/screens/widgets/splash_logo_widget.dart';
import 'package:thaheen/features/splash/presentation/screens/widgets/splash_title_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 1800), () {
      if (mounted) context.go(AppRouter.mainLayout);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      backgroundColor: colors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SplashLogoWidget(),
            SizedBox(height: 24.h),
            const SplashTitleWidget(),
            SizedBox(height: 48.h),
            const SplashLoadingIndicator(),
          ],
        ),
      ),
    );
  }
}

