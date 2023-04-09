import 'package:flutter/material.dart';

// Перечисление стилей текста
enum AppTextStyle {
  regular16(TextStyle(fontSize: 16, height: 1.40, color: Colors.black)),
  regular20(TextStyle(fontSize: 20, height: 1.40, color: Colors.black)),
  regular24(TextStyle(fontSize: 24, height: 1.24, color: Colors.black)),

  medium14(TextStyle(
      fontSize: 14,
      height: 1.40,
      fontWeight: FontWeight.w500,
      color: Colors.black)),
  medium24(TextStyle(
      fontSize: 24,
      height: 1.24,
      fontWeight: FontWeight.w500,
      color: Colors.black)),

  bold16(TextStyle(
      fontSize: 16,
      height: 1.24,
      fontWeight: FontWeight.w700,
      color: Colors.black)),
  bold24(TextStyle(
      fontSize: 24,
      height: 1.24,
      fontWeight: FontWeight.w700,
      color: Colors.black));

  final TextStyle value;

  const AppTextStyle(this.value);
}
