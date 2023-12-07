import 'package:flutter/material.dart';
import 'package:graduate_app/theme/palette.dart';

/// [Text] arguments,i.e., original [TextStyle].
class TextStyles {
  const TextStyles();

  /// fontSize: 32, fontWeight: FontWeight.w700,
  static TextStyle h1({Color color = Palette.blackColor}) => TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: color,
      );

  /// fontSize: 24, fontWeight: FontWeight.w700,
  static TextStyle h2({Color color = Palette.blackColor}) => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: color,
      );

  /// fontSize: 20, fontWeight: FontWeight.w700,
  static TextStyle h3({Color color = Palette.blackColor}) => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: color,
      );

  /// fontSize: 18, fontWeight: FontWeight.w700,
  static TextStyle h4({Color color = Palette.blackColor}) => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: color,
      );

  /// fontSize: 16, fontWeight: FontWeight.w700,
  static TextStyle p1Bold({Color color = Palette.blackColor}) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: color,
      );

  /// fontSize: 14, fontWeight: FontWeight.w700,
  static TextStyle p2Bold({Color color = Palette.blackColor}) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: color,
      );

  /// fontSize: 12, fontWeight: FontWeight.w700,
  static TextStyle p3Bold({Color color = Palette.blackColor}) => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: color,
      );

  /// fontSize: 10, fontWeight: FontWeight.w700,
  static TextStyle p4Bold({Color color = Palette.blackColor}) => TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: color,
      );

  /// fontSize: 8, fontWeight: FontWeight.w700,
  static TextStyle p5Bold({Color color = Palette.blackColor}) => TextStyle(
        fontSize: 8,
        fontWeight: FontWeight.w700,
        color: color,
      );

  /// fontSize: 16, fontWeight: FontWeight.w400,
  static TextStyle p1({Color color = Palette.blackColor}) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: color,
      );

  /// fontSize: 14, fontWeight: FontWeight.w400,
  static TextStyle p2({Color color = Palette.blackColor}) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: color,
      );

  /// fontSize: 12, fontWeight: FontWeight.w400,
  static TextStyle p3({Color color = Palette.blackColor}) => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: color,
      );

  /// fontSize: 10, fontWeight: FontWeight.w400,
  static TextStyle p4({Color color = Palette.blackColor}) => TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: color,
      );

  /// fontSize: 8, fontWeight: FontWeight.w400,
  static TextStyle p5({Color color = Palette.blackColor}) => TextStyle(
        fontSize: 8,
        fontWeight: FontWeight.w400,
        color: color,
      );
}
