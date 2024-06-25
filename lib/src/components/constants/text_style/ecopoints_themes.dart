import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/ecopoints_colors.dart';

class EcoPointsTextStyles {
  static greenTextStyle({required double size, required FontWeight weight}) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
        fontWeight: weight,
        fontSize: size,
        color: EcoPointsColors.green,
      ),
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
        color: EcoPointsColors.gray,
      ),
    );
  }
}
