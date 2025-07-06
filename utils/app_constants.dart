/// Kelas yang berisi konstanta-konstanta yang digunakan dalam aplikasi
/// 
/// Kelas ini menyediakan nilai-nilai konstan seperti URL API, nama aplikasi,
/// dan konstanta lainnya yang digunakan di seluruh aplikasi.
class AppConstants {
  /// URL dasar untuk API
  /// 
  /// Gunakan URL ini sebagai awalan untuk semua endpoint API
  static const String baseUrl = 'https://example.com/api/klinik';
  
  /// Nama aplikasi
  static const String appName = 'KLINIK App';
  
  /// Tagline aplikasi
  static const String appTagline = 'Kesehatan Anda Prioritas Kami';
  
  /// Durasi splash screen dalam detik
  static const int splashDuration = 3;
  
  /// Durasi animasi dalam milidetik
  static const int animationDuration = 300;
  
  /// Warna utama aplikasi dalam format hex
  static const String primaryColorHex = '#2196F3'; // Blue
  
  /// Warna sekunder aplikasi dalam format hex
  static const String secondaryColorHex = '#FFC107'; // Amber
  
  /// Ukuran padding standar
  static const double defaultPadding = 16.0;
  
  /// Ukuran radius sudut standar
  static const double defaultBorderRadius = 8.0;
  
  /// Ukuran font untuk judul
  static const double titleFontSize = 18.0;
  
  /// Ukuran font untuk subtitel
  static const double subtitleFontSize = 16.0;
  
  /// Ukuran font untuk teks biasa
  static const double bodyFontSize = 14.0;
  
  /// Pesan error default
  static const String defaultErrorMessage = 'Terjadi kesalahan. Silakan coba lagi.';
}
