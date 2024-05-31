import 'package:flutter/material.dart';

class SpaceHepler {
  static const verticalSmall = SizedBox(
    height: 10.0,
  );
  static const verticalMedium = SizedBox(
    height: 20.0,
  );
  static const verticalLarge = SizedBox(
    height: 30.0,
  );
  static const horizontalSmall = SizedBox(
    width: 10.0,
  );
  static const horizontalMedium = SizedBox(
    width: 20.0,
  );
  static const horizontalLarge = SizedBox(
    width: 30.0,
  );
  static  horizontalSpace(double size)=> SizedBox(
    width: size,
  );
  static verticalSpace(double size)=> SizedBox(
    height: size,
  );
}