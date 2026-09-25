import 'package:flutter/material.dart';
import 'package:thaheen/features/lesson_player/presentation/screens/widgets/speed_chip.dart';

class SpeedChipsWrap extends StatelessWidget {
  final double currentSpeed;
  final void Function(double speed) onSpeedSelected;

  const SpeedChipsWrap({
    super.key,
    required this.currentSpeed,
    required this.onSpeedSelected,
  });

  static const _speeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: _speeds
          .map((s) => SpeedChip(
                speed: s,
                isSelected: s == currentSpeed,
                onTap: () {
                  onSpeedSelected(s);
                  Navigator.pop(context);
                },
              ))
          .toList(),
    );
  }
}
