import 'package:flutter/material.dart';
import 'package:klinik_app/models/patient.dart';
import 'package:klinik_app/services/api_service.dart';

/// Layar untuk pendaftaran pasien baru
/// 
/// Layar ini menampilkan formulir pendaftaran pasien baru dengan
/// validasi input dan pengiriman data ke API.
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

/// State untuk RegistrationScreen
class _RegistrationScreenState extends State<RegistrationScreen> {
  /// Service untuk mengambil data dari API
  final ApiService _apiService = ApiService();
  
  /// Key untuk form validasi
  final _formKey = GlobalKey<FormState>();
  
  /// Controller untuk field nama pasien
  final TextEditingController _nameController = TextEditingController();
  
  /// Controller untuk field tanggal lahir pasien
  final TextEditingController _birthDateController = TextEditingController();
  
  /// Controller untuk field alamat pasien
  final TextEditingController _addressController = TextEditingController();
  
  /// Controller untuk field nomor telepon pasien
  final TextEditingController _phoneController = TextEditingController();
  
  /// Controller untuk field email pasien
  final TextEditingController _emailController = TextEditingController();

  /// Membersihkan resource saat widget dihapus
  /// 
  /// Membuang semua controller untuk mencegah memory leak.
  @override
  void dispose() {
    _nameController.dispose();
    _birthDateController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  /// Menampilkan date picker untuk memilih tanggal lahir
  /// 
  /// [context] adalah BuildContext yang digunakan untuk menampilkan dialog.
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthDateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  /// Mengirimkan data formulir ke API
  /// 
  /// Memvalidasi input, membuat objek Patient, dan mengirimkannya ke API.
  /// Menampilkan pesan sukses atau error sesuai dengan hasil operasi.
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
      
      try {
        // Create patient object
        final newPatient = Patient(
          id: 'P${DateTime.now().millisecondsSinceEpoch.toString().substring(9)}',
          name: _nameController.text,
          address: _addressController.text,
          phoneNumber: _phoneController.text,
          gender: 'Belum diisi', // Ini seharusnya dari dropdown di aplikasi nyata
          email: _emailController.text,
        );
        
        // Register patient using API service
        await _apiService.registerPatient(newPatient);
        
        // Check if widget is still mounted before using context
        if (!mounted) return;
        
        // Close loading dialog
        Navigator.of(context).pop();
        
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Pendaftaran berhasil! ID Pasien: ${newPatient.id}'),
            backgroundColor: Colors.green, // Hijau untuk sukses
          ),
        );
        
        // Clear form
        _formKey.currentState!.reset();
        _nameController.clear();
        _birthDateController.clear();
        _addressController.clear();
        _phoneController.clear();
        _emailController.clear();
      } catch (e) {
        // Check if widget is still mounted before using context
        if (!mounted) return;
        
        // Close loading dialog
        Navigator.of(context).pop();
        
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mendaftarkan pasien: ${e.toString()}'),
            backgroundColor: Colors.red, // Merah untuk error
          ),
        );
      }
    } else {
      // Show validation error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mohon lengkapi semua data dengan benar'),
          backgroundColor: Colors.red, // Merah untuk error
        ),
      );
    }
  }

  /// Membangun tampilan untuk layar pendaftaran
  /// 
  /// Menampilkan formulir pendaftaran dengan validasi input dan tombol submit.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pendaftaran'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Formulir Pendaftaran Pasien Baru',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama tidak boleh kosong';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 15.0),
            TextFormField(
              controller: _birthDateController,
              readOnly: true, // Make it read-only to use the date picker
              onTap: () => _selectDate(context), // Open date picker on tap
              decoration: const InputDecoration(
                labelText: 'Tanggal Lahir',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today),
                hintText: 'DD/MM/YYYY',
              ),
              keyboardType: TextInputType.datetime,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Tanggal lahir tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 15.0),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Alamat',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Alamat tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 15.0),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Nomor Telepon',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nomor telepon tidak boleh kosong';
                }
                // Basic phone number validation
                if (value.length < 10) {
                  return 'Nomor telepon minimal 10 digit';
                }
                return null;
              },
            ),
            const SizedBox(height: 15.0),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email tidak boleh kosong';
                } else if (!value.contains('@') || !value.contains('.')) { // More robust email validation
                  return 'Email tidak valid';
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Warna latar belakang tombol
                  foregroundColor: Colors.white, // Warna teks tombol
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Daftar Sekarang',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}