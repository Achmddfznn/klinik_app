import 'package:flutter/material.dart';
import 'package:klinik_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

/// Layar pengaturan aplikasi
/// 
/// Layar ini memungkinkan pengguna untuk mengubah berbagai pengaturan aplikasi
/// seperti tema, bahasa, dan notifikasi.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  /// Membangun tampilan untuk layar pengaturan
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle('Tampilan'),
          _buildThemeSettings(context),
          const Divider(),
          _buildSectionTitle('Tentang Aplikasi'),
          _buildAboutAppSettings(context),
        ],
      ),
    );
  }

  /// Membangun judul bagian pengaturan
  /// 
  /// [title] adalah judul bagian yang akan ditampilkan
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// Membangun pengaturan tema
  /// 
  /// Menampilkan opsi untuk mengubah tema aplikasi
  Widget _buildThemeSettings(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tema',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            RadioListTile<ThemeMode>(
              title: const Text('Terang'),
              value: ThemeMode.light,
              groupValue: themeProvider.themeMode,
              onChanged: (ThemeMode? value) {
                if (value != null) {
                  themeProvider.setLightMode();
                }
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Gelap'),
              value: ThemeMode.dark,
              groupValue: themeProvider.themeMode,
              onChanged: (ThemeMode? value) {
                if (value != null) {
                  themeProvider.setDarkMode();
                }
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Sistem'),
              value: ThemeMode.system,
              groupValue: themeProvider.themeMode,
              onChanged: (ThemeMode? value) {
                if (value != null) {
                  themeProvider.setSystemMode();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Membangun pengaturan tentang aplikasi
  /// 
  /// Menampilkan informasi tentang aplikasi seperti versi dan pengembang
  Widget _buildAboutAppSettings(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: const Text('Versi Aplikasi'),
              subtitle: const Text('1.0.0'),
              leading: const Icon(Icons.info_outline),
              onTap: () {
                // Tampilkan dialog informasi versi
                showAboutDialog(
                  context: context,
                  applicationName: 'KLINIK App',
                  applicationVersion: '1.0.0',
                  applicationIcon: const FlutterLogo(size: 48),
                  children: [
                    const Text('Aplikasi manajemen klinik untuk memudahkan pasien dan dokter.'),
                  ],
                );
              },
            ),
            ListTile(
              title: const Text('Kebijakan Privasi'),
              leading: const Icon(Icons.privacy_tip_outlined),
              onTap: () {
                // Navigasi ke halaman kebijakan privasi
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Kebijakan Privasi belum tersedia')),
                );
              },
            ),
            ListTile(
              title: const Text('Syarat dan Ketentuan'),
              leading: const Icon(Icons.description_outlined),
              onTap: () {
                // Navigasi ke halaman syarat dan ketentuan
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Syarat dan Ketentuan belum tersedia')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}