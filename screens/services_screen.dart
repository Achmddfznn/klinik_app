import 'package:flutter/material.dart';

/// Layar untuk menampilkan daftar layanan yang tersedia di klinik
/// 
/// Layar ini menampilkan daftar layanan dalam bentuk kartu yang dapat diklik
/// untuk melihat detail layanan (belum diimplementasikan).
class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  /// Daftar layanan yang tersedia di klinik
  final List<String> services = const [
    'Pemeriksaan Umum',
    'Vaksinasi',
    'Konsultasi Gizi',
    'Pemeriksaan Gigi',
    'Fisioterapi',
    'Laboratorium',
  ];

  /// Membangun tampilan untuk layar layanan
  /// 
  /// Menampilkan daftar layanan dalam bentuk ListView dengan Card untuk setiap layanan.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layanan'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: services.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), // Sudut membulat untuk kartu
            ),
            child: ListTile(
              leading: Icon(Icons.medical_services_outlined, color: Colors.blue[700]), // Biru yang sedikit lebih gelap
              title: Text(
                services[index],
                style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey), // Menambahkan ikon panah
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Anda memilih layanan: ${services[index]}')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}