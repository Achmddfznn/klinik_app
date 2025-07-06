import 'package:flutter/material.dart';

/// Kelas untuk mengelola tema aplikasi
/// 
/// Kelas ini menyediakan tema terang dan gelap untuk aplikasi,
/// serta berbagai konstanta tema yang digunakan di seluruh aplikasi.
class AppTheme {
  /// Tema terang aplikasi
  /// 
  /// Digunakan saat aplikasi dalam mode terang (light mode)
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue, // Warna latar belakang app bar
      foregroundColor: Colors.white, // Warna teks app bar
      elevation: 0, // Tanpa bayangan
      centerTitle: true, // Judul selalu di tengah
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue, // Warna latar belakang tombol
        foregroundColor: Colors.white, // Warna teks tombol
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Sudut membulat
        ),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 2, // Bayangan ringan
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Sudut membulat
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[100], // Warna latar belakang input
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8), // Sudut membulat
        borderSide: BorderSide.none, // Tanpa garis tepi
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[300]!), // Garis tepi ringan
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.blue), // Garis tepi biru saat fokus
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
      titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black87),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue, // Warna item yang dipilih
      unselectedItemColor: Colors.grey, // Warna item yang tidak dipilih
      type: BottomNavigationBarType.fixed, // Tipe fixed agar semua item terlihat
      elevation: 8, // Bayangan untuk memberikan efek kedalaman
    ),
  );

  /// Tema gelap aplikasi
  /// 
  /// Digunakan saat aplikasi dalam mode gelap (dark mode)
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[850], // Warna latar belakang app bar
      foregroundColor: Colors.white, // Warna teks app bar
      elevation: 0, // Tanpa bayangan
      centerTitle: true, // Judul selalu di tengah
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue, // Warna latar belakang tombol
        foregroundColor: Colors.white, // Warna teks tombol
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Sudut membulat
        ),
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.grey[850], // Warna latar belakang kartu
      elevation: 2, // Bayangan ringan
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Sudut membulat
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[800], // Warna latar belakang input
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8), // Sudut membulat
        borderSide: BorderSide.none, // Tanpa garis tepi
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[700]!), // Garis tepi ringan
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.blue), // Garis tepi biru saat fokus
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.white70),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.white70),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[900],
      selectedItemColor: Colors.blue, // Warna item yang dipilih
      unselectedItemColor: Colors.grey[400], // Warna item yang tidak dipilih
      type: BottomNavigationBarType.fixed, // Tipe fixed agar semua item terlihat
      elevation: 8, // Bayangan untuk memberikan efek kedalaman
    ),
  );
}