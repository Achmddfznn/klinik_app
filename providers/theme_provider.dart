import 'package:flutter/material.dart';

/// Provider untuk mengelola tema aplikasi
/// 
/// Kelas ini menyediakan fungsi untuk mengubah tema aplikasi
/// antara tema terang dan gelap secara dinamis.
class ThemeProvider extends ChangeNotifier {
  /// Mode tema saat ini
  /// 
  /// Nilai default adalah ThemeMode.system yang mengikuti tema sistem
  ThemeMode _themeMode = ThemeMode.system;

  /// Getter untuk mendapatkan mode tema saat ini
  ThemeMode get themeMode => _themeMode;

  /// Mengubah tema menjadi tema terang
  void setLightMode() {
    _themeMode = ThemeMode.light;
    notifyListeners();
  }

  /// Mengubah tema menjadi tema gelap
  void setDarkMode() {
    _themeMode = ThemeMode.dark;
    notifyListeners();
  }

  /// Mengubah tema mengikuti tema sistem
  void setSystemMode() {
    _themeMode = ThemeMode.system;
    notifyListeners();
  }

  /// Mengubah tema berdasarkan nilai boolean
  /// 
  /// [isDark] true untuk tema gelap, false untuk tema terang
  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}