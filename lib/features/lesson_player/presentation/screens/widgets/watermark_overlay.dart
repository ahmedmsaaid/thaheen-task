import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:thaheen/core/theme/app_text_styles.dart';

class WatermarkOverlay extends StatefulWidget {
  final String text;
  const WatermarkOverlay({super.key, required this.text});

  @override
  State<WatermarkOverlay> createState() => _WatermarkOverlayState();
}

class _WatermarkOverlayState extends State<WatermarkOverlay> {
  Timer? _timer;
  Alignment _alignment = Alignment.center;
  final _rng = Random();

  static const _positions = [
    Alignment.topLeft, Alignment.topCenter, Alignment.topRight,
    Alignment.centerLeft, Alignment.center, Alignment.centerRight,
    Alignment.bottomLeft, Alignment.bottomCenter, Alignment.bottomRight,
  ];

  @override
  void initState() {
    super.initState();
    _shuffle();
    _timer = Timer.periodic(
      Duration(seconds: 20 + _rng.nextInt(10)),
      (_) => _shuffle(),
    );
  }

  void _shuffle() {
    if (!mounted) return;
    setState(() => _alignment = _positions[_rng.nextInt(_positions.length)]);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: AnimatedAlign(
          alignment: _alignment,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: Text(
              widget.text,
              style: AppTextStyles.caption(context).copyWith(
                color: Colors.white.withValues(alpha: 0.15),
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
