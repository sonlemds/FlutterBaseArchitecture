import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

enum AppFontFamily { poppins, kalam }

enum AppFontWeight { light, regular, medium, semiBold, bold, black }

extension AppFontFamilyDefault on AppFontFamily {
  String get font {
    switch (this) {
      case AppFontFamily.poppins:
        return 'Poppins';
      case AppFontFamily.kalam:
        return 'Kalam';
    }
  }
}

extension PoppinsFontWeight on AppFontWeight {
  FontWeight get weight {
    switch (this) {
      case AppFontWeight.light:
        return FontWeight.w300;
      case AppFontWeight.regular:
        return FontWeight.w400;
      case AppFontWeight.medium:
        return FontWeight.w500;
      case AppFontWeight.semiBold:
        return FontWeight.w600;
      case AppFontWeight.bold:
        return FontWeight.w700;
      case AppFontWeight.black:
        return FontWeight.w900;
    }
  }
}

class AppTextStyles {
  const AppTextStyles._();

  static PoppinsStyles poppinsStyle = PoppinsStyles();
}

class PoppinsStyles {
  static TextStyle customPoppinsStyle(
    double size,
    Color color,
    AppFontWeight fontWeight,
  ) {
    return GoogleFonts.poppins(
      color: color,
      fontWeight: fontWeight.weight,
      fontSize: size,
    );
  }

  final heading1 = GoogleFonts.poppins(
    color: AppColors.magnolia,
    fontWeight: AppFontWeight.bold.weight,
    fontSize: 48,
  );

  final heading2 = GoogleFonts.poppins(
    color: AppColors.magnolia,
    fontWeight: AppFontWeight.semiBold.weight,
    fontSize: 36,
  );

  final heading3 = GoogleFonts.poppins(
    color: AppColors.magnolia,
    fontWeight: AppFontWeight.bold.weight,
    fontSize: 30,
  );

  final heading4 = GoogleFonts.poppins(
    color: AppColors.magnolia,
    fontWeight: AppFontWeight.semiBold.weight,
    fontSize: 24,
  );

  final subTitle1 = GoogleFonts.poppins(
    color: AppColors.magnolia,
    fontWeight: AppFontWeight.medium.weight,
    fontSize: 16,
  );

  final subTitle2 = GoogleFonts.poppins(
    color: AppColors.magnolia,
    fontWeight: AppFontWeight.medium.weight,
    fontSize: 14,
  );

  final body1 = GoogleFonts.poppins(
    color: AppColors.magnolia,
    fontWeight: AppFontWeight.regular.weight,
    fontSize: 16,
  );

  final body2 = GoogleFonts.poppins(
    color: AppColors.magnolia,
    fontWeight: AppFontWeight.regular.weight,
    fontSize: 14,
  );

  final body3 = GoogleFonts.poppins(
    color: AppColors.magnolia,
    fontWeight: AppFontWeight.regular.weight,
    fontSize: 12,
  );
}
