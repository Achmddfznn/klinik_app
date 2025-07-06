import 'package:flutter/material.dart';

/// Widget BottomNavigationBar kustom yang dapat digunakan di seluruh aplikasi
/// 
/// Widget ini menyediakan tampilan BottomNavigationBar yang konsisten dengan
/// item navigasi yang sesuai dengan kebutuhan aplikasi.
class CustomBottomNavBar extends StatelessWidget {
  /// Indeks item yang dipilih saat ini
  final int selectedIndex;
  
  /// Callback yang dipanggil saat item ditekan
  final Function(int) onItemTapped;

  /// Constructor untuk membuat CustomBottomNavBar
  /// 
  /// [selectedIndex] adalah indeks item yang dipilih saat ini
  /// [onItemTapped] adalah callback yang dipanggil saat item ditekan
  const CustomBottomNavBar({
    super.key, 
    required this.selectedIndex, 
    required this.onItemTapped,
  });

  /// Membangun tampilan untuk CustomBottomNavBar
  /// 
  /// Mengembalikan widget BottomNavigationBar dengan item navigasi yang sesuai
  /// dengan kebutuhan aplikasi.
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Jadwal Dokter',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.medical_services),
          label: 'Layanan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.app_registration),
          label: 'Pendaftaran',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Pengaturan',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: onItemTapped,
      type: BottomNavigationBarType.fixed, // Memastikan semua item terlihat
    );
  }
}
