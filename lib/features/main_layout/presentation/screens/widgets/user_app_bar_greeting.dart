import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thaheen/core/constants/app_strings.dart';

class UserAppBarGreeting extends StatelessWidget {
  const UserAppBarGreeting({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.userGreeting,
          style: GoogleFonts.cairo(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        Text(
          AppStrings.userSubtitle,
          style: GoogleFonts.cairo(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: Colors.white.withValues(alpha: 0.82),
          ),
        ),
      ],
    );
  }
}
