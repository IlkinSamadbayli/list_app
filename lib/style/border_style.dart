import 'package:flutter/material.dart';
import 'package:provider_test/style/custom_color.dart';

class AppBorder {
  static InputDecoration kBorderDecoration({hintText}) => InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: CustomColor.borderColor, width: 3)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: CustomColor.borderColor, width: 3)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: CustomColor.borderColor, width: 3)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: CustomColor.errorColor, width: 3)),
      );

  static dynamic kButtonStyle(Color color) => ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      );
}
