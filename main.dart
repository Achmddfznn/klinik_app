import 'package:flutter/material.dart';
import 'package:klinik_app/screens/splash_screen.dart';
import 'package:klinik_app/utils/theme.dart';
import 'package:klinik_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

/// Titik masuk utama aplikasi
/// 
/// Fungsi ini dipanggil pertama kali saat aplikasi dijalankan
void main() async {
  // Pastikan widget binding diinisialisasi
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inisialisasi Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

/// Widget root aplikasi
/// 
/// Kelas ini mendefinisikan tema dan konfigurasi dasar aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// Membangun widget tree utama aplikasi
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'KLINIK App',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode, // Menggunakan tema dari provider
          home: const SplashScreen(),
        );
      },
    );
  }
}