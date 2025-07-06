import 'package:flutter/material.dart';
import 'package:klinik_app/models/doctor.dart';
import 'package:klinik_app/services/api_service.dart';

/// Layar untuk menampilkan jadwal dokter
/// 
/// Layar ini menampilkan daftar dokter beserta jadwal praktiknya
/// yang diambil dari API menggunakan ApiService.
class DoctorScheduleScreen extends StatefulWidget {
  const DoctorScheduleScreen({super.key});

  @override
  State<DoctorScheduleScreen> createState() => _DoctorScheduleScreenState();
}

/// State untuk DoctorScheduleScreen
class _DoctorScheduleScreenState extends State<DoctorScheduleScreen> {
  /// Service untuk mengambil data dari API
  final ApiService _apiService = ApiService();
  
  /// Daftar dokter yang akan ditampilkan
  List<Doctor> _doctors = [];
  
  /// Status loading data
  bool _isLoading = true;
  
  /// Pesan error jika terjadi kesalahan saat mengambil data
  String? _errorMessage;
  
  /// Inisialisasi state
  /// 
  /// Dipanggil saat widget pertama kali dibuat.
  /// Memanggil _loadDoctors() untuk mengambil data dokter saat layar dibuka.
  @override
  void initState() {
    super.initState();
    _loadDoctors();
  }
  
  /// Mengambil data dokter dari API
  /// 
  /// Metode ini memanggil ApiService.fetchDoctors() untuk mengambil data dokter
  /// dan memperbarui state sesuai dengan hasil yang diperoleh.
  Future<void> _loadDoctors() async {
    try {
      final doctors = await _apiService.fetchDoctors();
      setState(() {
        _doctors = doctors;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Gagal memuat data dokter: ${e.toString()}';
      });
    }
  }

  /// Membangun tampilan untuk layar jadwal dokter
  /// 
  /// Menampilkan loading indicator saat data sedang dimuat,
  /// pesan error jika terjadi kesalahan, atau daftar dokter jika berhasil.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Dokter'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _isLoading = true;
                _errorMessage = null;
              });
              _loadDoctors();
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                            _errorMessage = null;
                          });
                          _loadDoctors();
                        },
                        child: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                )
              : _doctors.isEmpty
                  ? const Center(child: Text('Tidak ada jadwal dokter yang tersedia'))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: _doctors.length,
                      itemBuilder: (context, index) {
                        final doctor = _doctors[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          elevation: 3.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0), // Sudut membulat untuk kartu
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doctor.name,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue, // Menyoroti nama dokter
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text('Spesialis: ${doctor.specialty}', style: const TextStyle(fontSize: 15.0)),
                                Text('Hari: ${doctor.scheduleDay}', style: const TextStyle(fontSize: 15.0)),
                                Text('Jam: ${doctor.scheduleTime}', style: const TextStyle(fontSize: 15.0)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}