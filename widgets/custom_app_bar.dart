import 'package:flutter/material.dart';

/// Widget AppBar kustom yang dapat digunakan di seluruh aplikasi
/// 
/// Widget ini menyediakan tampilan AppBar yang konsisten dengan
/// judul yang terpusat dan warna yang sesuai dengan tema aplikasi.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Judul yang akan ditampilkan di tengah AppBar
  final String title;
  
  /// Daftar widget yang akan ditampilkan di sisi kanan AppBar (opsional)
  final List<Widget>? actions;

  /// Constructor untuk membuat CustomAppBar
  /// 
  /// [title] adalah judul yang akan ditampilkan di tengah AppBar
  /// [actions] adalah daftar widget yang akan ditampilkan di sisi kanan AppBar (opsional)
  const CustomAppBar({super.key, required this.title, this.actions});

  /// Membangun tampilan untuk CustomAppBar
  /// 
  /// Mengembalikan widget AppBar dengan judul yang terpusat dan warna yang sesuai dengan tema aplikasi.
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      actions: actions,
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    );
  }

  /// Ukuran yang diinginkan untuk CustomAppBar
  /// 
  /// Mengembalikan ukuran standar untuk AppBar menggunakan kToolbarHeight.
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
