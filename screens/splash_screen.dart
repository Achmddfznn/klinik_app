import 'package:flutter/material.dart';
import 'package:klinik_app/screens/home_screen.dart';

/// Layar splash yang ditampilkan saat aplikasi pertama kali dibuka
/// 
/// Layar ini menampilkan logo, nama aplikasi, dan tagline selama beberapa detik
/// sebelum berpindah ke HomeScreen.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

/// State untuk SplashScreen
class _SplashScreenState extends State<SplashScreen> {
  /// Inisialisasi state
  /// 
  /// Dipanggil saat widget pertama kali dibuat.
  /// Memanggil _navigateToHome() untuk berpindah ke HomeScreen setelah delay.
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  /// Berpindah ke HomeScreen setelah delay
  /// 
  /// Metode ini menunggu selama 3 detik sebelum berpindah ke HomeScreen.
  /// Pemeriksaan mounted dilakukan untuk menghindari error jika widget
  /// sudah tidak ada di tree saat navigasi dilakukan.
  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  /// Membangun tampilan untuk layar splash
  /// 
  /// Menampilkan logo, nama aplikasi, tagline, dan loading indicator
  /// dengan layout yang terpusat.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.local_hospital,
                size: 80,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            // App name
            const Text(
              'KLINIK APP',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 12),
            // Tagline
            const Text(
              'Kesehatan Anda Prioritas Kami',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 48),
            // Loading indicator
            const CircularProgressIndicator(color: Colors.blue),
          ],
        ),
      ),
    );
  }
}