import 'package:flutter/material.dart';
import 'package:klinik_app/screens/doctor_schedule_screen.dart';
import 'package:klinik_app/screens/registration_screen.dart';
import 'package:klinik_app/screens/services_screen.dart';
import 'package:klinik_app/screens/patient_details_screen.dart';
import 'package:klinik_app/screens/settings_screen.dart';
import 'package:klinik_app/widgets/custom_bottom_nav_bar.dart';

/// Layar utama aplikasi
/// 
/// Layar ini menampilkan dashboard dengan fitur-fitur utama aplikasi
/// dan bottom navigation bar untuk navigasi ke layar lainnya.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// State untuk HomeScreen
class _HomeScreenState extends State<HomeScreen> {
  /// Indeks item yang dipilih pada bottom navigation bar
  int _selectedIndex = 0;

  /// Daftar widget yang akan ditampilkan sesuai dengan indeks yang dipilih
  late final List<Widget> _widgetOptions;

  /// Inisialisasi state
  /// 
  /// Dipanggil saat widget pertama kali dibuat.
  /// Menginisialisasi daftar widget yang akan ditampilkan pada bottom navigation bar.
  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      _buildDashboard(context), // Mengirim context ke metode _buildDashboard
      const DoctorScheduleScreen(),
      const ServicesScreen(),
      const RegistrationScreen(),
      const SettingsScreen(),
    ];
  }

  /// Callback saat item pada bottom navigation bar ditekan
  /// 
  /// Mengubah indeks yang dipilih dan memperbarui tampilan.
  /// 
  /// [index] adalah indeks item yang ditekan pada bottom navigation bar.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /// Membangun tampilan dashboard
  /// 
  /// Menampilkan grid dengan kartu-kartu fitur utama aplikasi.
  /// 
  /// [context] adalah BuildContext yang digunakan untuk navigasi.
  Widget _buildDashboard(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KLINIK'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: <Widget>[
            _buildFeatureCard(
              icon: Icons.home,
              title: 'Beranda',
              onTap: () {
                // Already on Home, so no navigation needed
              },
            ),
            _buildFeatureCard(
              icon: Icons.calendar_today,
              title: 'Jadwal Dokter',
              onTap: () {
                setState(() {
                  _selectedIndex = 1; // Navigate via bottom nav bar
                });
              },
            ),
            _buildFeatureCard(
              icon: Icons.medical_services,
              title: 'Layanan',
              onTap: () {
                setState(() {
                  _selectedIndex = 2; // Navigate via bottom nav bar
                });
              },
            ),
            _buildFeatureCard(
              icon: Icons.app_registration,
              title: 'Pendaftaran',
              onTap: () {
                setState(() {
                  _selectedIndex = 3; // Navigate via bottom nav bar
                });
              },
            ),
             _buildFeatureCard(
              icon: Icons.person,
              title: 'Data Pasien',
              onTap: () {
                // Navigasi ke PatientDetailsScreen dengan ID pasien default
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const PatientDetailsScreen(patientId: 'PAT001')),
                );
              },
            ),
            _buildFeatureCard(
              icon: Icons.settings,
              title: 'Pengaturan',
              onTap: () {
                setState(() {
                  _selectedIndex = 4; // Navigate to Settings via bottom nav bar
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Membangun kartu fitur untuk dashboard
  /// 
  /// [icon] adalah ikon yang ditampilkan pada kartu.
  /// [title] adalah judul fitur yang ditampilkan pada kartu.
  /// [onTap] adalah callback yang dipanggil saat kartu ditekan.
  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 50.0, color: Colors.blue),
            const SizedBox(height: 10.0),
            Text(
              title,
              style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Membangun tampilan utama HomeScreen
  /// 
  /// Menampilkan widget yang sesuai dengan indeks yang dipilih
  /// dan bottom navigation bar untuk navigasi.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}