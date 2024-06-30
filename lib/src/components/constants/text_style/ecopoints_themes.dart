import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/ecopoints_colors.dart';

class EcoPointsTextStyles {
  static whiteSuezOneTextStyle(
      {required double size, required FontWeight weight}) {
    return GoogleFonts.suezOne(
      textStyle: TextStyle(
        fontWeight: weight,
        fontSize: size,
        color: EcoPointsColors.white,
      ),
    );
  }

  static whiteTextStyle({required double size, required FontWeight weight}) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
        fontWeight: weight,
        fontSize: size,
        color: EcoPointsColors.white,
      ),
    );
  }

  static redTextStyle({required double size, required FontWeight weight}) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
        fontWeight: weight,
        fontSize: size,
        color: EcoPointsColors.red,
      ),
    );
  }

  static darkGreenTextStyle(
      {required double size,
      required FontWeight weight,
      TextDecoration? decoration}) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
          fontWeight: weight,
          fontSize: size,
          color: EcoPointsColors.darkGreen,
          decoration: decoration),
    );
  }

  static lightGreenTextStyle(
      {required double size,
      required FontWeight weight,
      TextDecoration? decoration}) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
          fontWeight: weight,
          fontSize: size,
          color: EcoPointsColors.lightGreen,
          decoration: decoration),
    );
  }

  static blackTextStyle({required double size, required FontWeight weight}) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
        fontWeight: weight,
        fontSize: size,
        color: EcoPointsColors.black,
      ),
    );
  }

  static grayTextStyle({required double size, required FontWeight weight}) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
        fontWeight: weight,
        fontSize: size,
        color: EcoPointsColors.darkGray,
      ),
    );
  }
}
