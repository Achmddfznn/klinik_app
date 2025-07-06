import 'package:flutter/material.dart';
import 'package:klinik_app/models/patient.dart';
import 'package:klinik_app/services/api_service.dart';

/// Layar untuk menampilkan dan mengedit detail pasien
/// 
/// Layar ini menampilkan informasi detail pasien berdasarkan ID yang diberikan.
/// Jika ID tidak diberikan, akan menampilkan data dummy.
class PatientDetailsScreen extends StatefulWidget {
  /// ID pasien yang akan ditampilkan detailnya
  /// 
  /// Jika null, akan menggunakan data dummy
  final String? patientId;
  
  const PatientDetailsScreen({super.key, this.patientId});

  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
}

/// State untuk PatientDetailsScreen
class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  /// Service untuk mengambil data dari API
  final ApiService _apiService = ApiService();
  
  /// Data pasien yang akan ditampilkan
  Patient? _patient;
  
  /// Status loading data
  bool _isLoading = true;
  
  /// Pesan error jika terjadi kesalahan saat mengambil data
  String? _errorMessage;

  /// Controller untuk field nama pasien
  final TextEditingController _nameController = TextEditingController();
  
  /// Controller untuk field alamat pasien
  final TextEditingController _addressController = TextEditingController();
  
  /// Controller untuk field nomor telepon pasien
  final TextEditingController _phoneController = TextEditingController();
  
  /// Controller untuk field jenis kelamin pasien
  final TextEditingController _genderController = TextEditingController();
  
  /// Controller untuk field email pasien
  final TextEditingController _emailController = TextEditingController();

  /// Status apakah sedang dalam mode edit
  bool _isEditing = false;

  /// Inisialisasi state
  /// 
  /// Dipanggil saat widget pertama kali dibuat.
  /// Memanggil _loadPatientData() untuk mengambil data pasien.
  @override
  void initState() {
    super.initState();
    _loadPatientData();
  }
  
  /// Mengambil data pasien dari API atau menggunakan data dummy
  /// 
  /// Jika patientId tidak null, akan mengambil data dari API.
  /// Jika patientId null, akan menggunakan data dummy.
  Future<void> _loadPatientData() async {
    if (widget.patientId == null) {
      // Jika tidak ada ID pasien, gunakan data dummy
      setState(() {
        _patient = Patient(
          id: 'P001',
          name: 'Budi Santoso',
          address: 'Jl. Merdeka No. 10, Jakarta',
          phoneNumber: '081234567890',
          gender: 'Laki-laki',
          email: 'budi.santoso@example.com',
        );
        _isLoading = false;
        _initializeControllers();
      });
      return;
    }
    
    try {
      final patient = await _apiService.getPatientById(widget.patientId!);
      setState(() {
        _patient = patient;
        _isLoading = false;
        if (patient != null) {
          _initializeControllers();
        } else {
          _errorMessage = 'Pasien tidak ditemukan';
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Gagal memuat data pasien: ${e.toString()}';
      });
    }
  }
  
  /// Menginisialisasi controller dengan data pasien
  /// 
  /// Mengisi nilai controller dengan data pasien yang sudah diambil.
  void _initializeControllers() {
    if (_patient != null) {
      _nameController.text = _patient!.name;
      _addressController.text = _patient!.address;
      _phoneController.text = _patient!.phoneNumber;
      _genderController.text = _patient!.gender;
      _emailController.text = _patient!.email;
    }
  }

  /// Membersihkan resource saat widget dihapus
  /// 
  /// Membuang semua controller untuk mencegah memory leak.
  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _genderController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  /// Mengubah mode edit dan menyimpan perubahan
  /// 
  /// Jika sedang dalam mode edit, akan menyimpan perubahan.
  /// Jika tidak dalam mode edit, akan mengaktifkan mode edit.
  Future<void> _toggleEditing() async {
    if (_isEditing) {
      // Jika sedang dalam mode edit dan ingin menyimpan
      setState(() {
        _isLoading = true;
      });
      
      try {
        // Buat objek pasien baru dengan data yang diperbarui
        final updatedPatient = Patient(
          id: _patient!.id, // ID tetap sama
          name: _nameController.text,
          address: _addressController.text,
          phoneNumber: _phoneController.text,
          gender: _genderController.text,
          email: _emailController.text,
        );
        
        // Di sini seharusnya ada panggilan API untuk memperbarui data pasien
        // Contoh: await _apiService.updatePatient(updatedPatient);
        // Karena belum diimplementasikan, kita hanya update state lokal
        
        setState(() {
          _patient = updatedPatient;
          _isLoading = false;
          _isEditing = false;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data pasien berhasil disimpan!')),
        );
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan data: ${e.toString()}')),
        );
      }
    } else {
      // Jika ingin masuk ke mode edit
      setState(() {
        _isEditing = true;
      });
    }
  }

  /// Membangun tampilan untuk layar detail pasien
  /// 
  /// Menampilkan loading indicator saat data sedang dimuat,
  /// pesan error jika terjadi kesalahan, atau detail pasien jika berhasil.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pasien'),
        centerTitle: true,
        actions: [
          if (_patient != null)
            IconButton(
              icon: Icon(_isEditing ? Icons.save : Icons.edit),
              onPressed: _toggleEditing,
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!, style: const TextStyle(color: Colors.red)))
              : _patient == null
                  ? const Center(child: Text('Data pasien tidak ditemukan'))
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildInfoRow('ID Pasien:', _patient!.id, editable: false),
                          _buildEditableField('Nama Lengkap:', _nameController, _isEditing),
                          _buildEditableField('Alamat:', _addressController, _isEditing),
                          _buildEditableField('Nomor Telepon:', _phoneController, _isEditing, keyboardType: TextInputType.phone),
                          _buildEditableField('Jenis Kelamin:', _genderController, _isEditing),
                          _buildEditableField('Email:', _emailController, _isEditing, keyboardType: TextInputType.emailAddress),
                        ],
                      ),
                    ),
    );
  }

  /// Membangun baris informasi yang tidak dapat diedit
  /// 
  /// [label] adalah label untuk informasi.
  /// [value] adalah nilai informasi.
  /// [editable] menentukan apakah informasi dapat diedit (tidak digunakan).
  Widget _buildInfoRow(String label, String value, {bool editable = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }

  /// Membangun field yang dapat diedit
  /// 
  /// [label] adalah label untuk field.
  /// [controller] adalah controller untuk field.
  /// [isEditing] menentukan apakah field dapat diedit.
  /// [keyboardType] adalah tipe keyboard yang digunakan untuk input.
  Widget _buildEditableField(
      String label, TextEditingController controller, bool isEditing,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
          const SizedBox(height: 5.0),
          TextFormField(
            controller: controller,
            readOnly: !isEditing,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              filled: !isEditing,
              fillColor: isEditing ? Colors.transparent : Colors.grey[200],
            ),
            style: const TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}