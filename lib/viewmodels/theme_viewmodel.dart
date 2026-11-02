import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_viewmodel.g.dart';

const String _appBarColorKey = 'appbar_color_key';

// Available colors including blue (xanh dương), green (xanh lá), purple (tím)
class AppColors {
  static const Color darkCharcoal = Color(0xFF2C3437); // Default color as in screenshot
  static const Color blue = Color(0xFF1976D2); // Xanh dương
  static const Color green = Color(0xFF388E3C); // Xanh lá
  static const Color purple = Color(0xFF7B1FA2); // Tím
  static const Color teal = Color(0xFF00796B);
  static const Color orange = Color(0xFFE65100);
  static const Color indigo = Color(0xFF303F9F);
  static const Color grey = Color(0xFF616161);

  static const List<Color> selectableColors = [
    darkCharcoal,
    blue,
    green,
    purple,
    teal,
    orange,
    indigo,
    grey,
  ];
}

@riverpod
class AppBarColorViewModel extends _$AppBarColorViewModel {
  @override
  Color build() {
    _loadSavedColor();
    return AppColors.darkCharcoal;
  }

  Future<void> _loadSavedColor() async {
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getInt(_appBarColorKey);
    if (colorValue != null) {
      state = Color(colorValue);
    }
  }

  Future<void> setColor(Color color) async {
    state = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_appBarColorKey, color.toARGB32());
  }
}
