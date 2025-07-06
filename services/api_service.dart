import 'package:flutter/foundation.dart';
import 'package:klinik_app/models/doctor.dart';
import 'package:klinik_app/models/patient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Kelas untuk menangani semua interaksi dengan Firebase
/// 
/// Kelas ini menyediakan metode untuk mengambil data dokter,
/// mendaftarkan pasien baru, dan mengambil detail pasien berdasarkan ID.
/// Menggunakan Firebase Firestore untuk penyimpanan data.
class ApiService {
  /// Instance Firestore untuk akses database
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  /// Mengambil daftar dokter dari Firestore
  /// 
  /// Returns [List<Doctor>] jika berhasil
  /// Throws [Exception] jika gagal mengambil data
  Future<List<Doctor>> fetchDoctors() async {
    try {
      // Mengambil data dokter dari koleksi 'doctors' di Firestore
      final QuerySnapshot snapshot = await _firestore.collection('doctors').get();
      
      // Jika tidak ada data, kembalikan data dummy untuk sementara
      if (snapshot.docs.isEmpty) {
        // Tambahkan beberapa dokter dummy ke Firestore jika koleksi kosong
        await _addDummyDoctors();
        
        // Ambil data lagi setelah menambahkan data dummy
        final QuerySnapshot newSnapshot = await _firestore.collection('doctors').get();
        return newSnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Doctor(
            id: doc.id,
            name: data['name'] as String,
            specialty: data['specialty'] as String,
            scheduleDay: data['scheduleDay'] as String,
            scheduleTime: data['scheduleTime'] as String,
          );
        }).toList();
      }
      
      // Konversi dokumen Firestore ke objek Doctor
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Doctor(
          id: doc.id,
          name: data['name'] as String,
          specialty: data['specialty'] as String,
          scheduleDay: data['scheduleDay'] as String,
          scheduleTime: data['scheduleTime'] as String,
        );
      }).toList();
    } catch (e) {
      debugPrint('Error fetching doctors: $e');
      throw Exception('Gagal memuat data dokter: $e');
    }
  }
  
  /// Menambahkan data dokter dummy ke Firestore
  /// 
  /// Method ini hanya digunakan jika koleksi 'doctors' kosong
  Future<void> _addDummyDoctors() async {
    try {
      final batch = _firestore.batch();
      
      // Dokter 1
      final doc1Ref = _firestore.collection('doctors').doc('DOC001');
      batch.set(doc1Ref, {
        'name': 'Dr. Ahmad Subarjo',
        'specialty': 'Umum',
        'scheduleDay': 'Senin, Rabu',
        'scheduleTime': '10:00 - 17:00',
      });
      
      // Dokter 2
      final doc2Ref = _firestore.collection('doctors').doc('DOC002');
      batch.set(doc2Ref, {
        'name': 'Dr. Siti Rahayu',
        'specialty': 'Anak',
        'scheduleDay': 'Selasa, Kamis',
        'scheduleTime': '09:00 - 16:00',
      });
      
      // Dokter 3
      final doc3Ref = _firestore.collection('doctors').doc('DOC003');
      batch.set(doc3Ref, {
        'name': 'Dr. Budi Santoso',
        'specialty': 'Gigi',
        'scheduleDay': 'Jumat',
        'scheduleTime': '14:00 - 20:00',
      });
      
      // Commit batch
      await batch.commit();
      debugPrint('Dummy doctors added to Firestore');
    } catch (e) {
      debugPrint('Error adding dummy doctors: $e');
    }
  }
  
  /// Mendaftarkan pasien baru ke Firestore
  /// 
  /// Parameter [patient] adalah data pasien yang akan didaftarkan
  /// Returns void jika berhasil
  /// Throws [Exception] jika gagal mendaftarkan pasien
  Future<void> registerPatient(Patient patient) async {
    try {
      // Menyimpan data pasien ke koleksi 'patients' di Firestore
      // Jika ID sudah ada, gunakan ID tersebut, jika tidak, biarkan Firestore generate ID
      if (patient.id.isNotEmpty && !patient.id.startsWith('P')) {
        // Gunakan ID yang sudah ada
        await _firestore.collection('patients').doc(patient.id).set(patient.toJson());
      } else {
        // Generate ID baru dengan format P + timestamp
        final String newId = 'P${DateTime.now().millisecondsSinceEpoch.toString().substring(9)}';
        final Patient newPatient = Patient(
          id: newId,
          name: patient.name,
          address: patient.address,
          phoneNumber: patient.phoneNumber,
          gender: patient.gender,
          email: patient.email,
        );
        
        await _firestore.collection('patients').doc(newId).set(newPatient.toJson());
      }
      
      debugPrint('Pasien berhasil didaftarkan: ${patient.name}');
      return;
    } catch (e) {
      debugPrint('Error registering patient: $e');
      throw Exception('Gagal mendaftarkan pasien: $e');
    }
  }
  
  /// Mengambil detail pasien berdasarkan ID dari Firestore
  /// 
  /// Parameter [id] adalah ID pasien yang akan dicari
  /// Returns [Patient] jika ditemukan, null jika tidak ditemukan
  /// Throws [Exception] jika gagal mengambil data
  Future<Patient?> getPatientById(String id) async {
    try {
      // Mengambil data pasien dari Firestore berdasarkan ID
      final DocumentSnapshot doc = await _firestore.collection('patients').doc(id).get();
      
      // Jika dokumen tidak ada, kembalikan null
      if (!doc.exists) {
        // Cek apakah ini adalah pertama kali aplikasi dijalankan, jika ya, tambahkan data dummy
        final QuerySnapshot patientsCheck = await _firestore.collection('patients').limit(1).get();
        if (patientsCheck.docs.isEmpty) {
          // Tambahkan pasien dummy jika koleksi kosong
          await _addDummyPatient();
          
          // Cek lagi apakah ID yang diminta adalah ID dummy
          if (id == 'PAT001') {
            final DocumentSnapshot newDoc = await _firestore.collection('patients').doc(id).get();
            if (newDoc.exists) {
              final data = newDoc.data() as Map<String, dynamic>;
              return Patient.fromJson(data);
            }
          }
        }
        return null;
      }
      
      // Konversi dokumen Firestore ke objek Patient
      final data = doc.data() as Map<String, dynamic>;
      return Patient.fromJson(data);
    } catch (e) {
      debugPrint('Error getting patient: $e');
      throw Exception('Gagal memuat data pasien: $e');
    }
  }
  
  /// Menambahkan data pasien dummy ke Firestore
  /// 
  /// Method ini hanya digunakan jika koleksi 'patients' kosong
  Future<void> _addDummyPatient() async {
    try {
      await _firestore.collection('patients').doc('PAT001').set({
        'id': 'PAT001',
        'name': 'Budi Setiawan',
        'address': 'Jl. Merdeka No. 123, Jakarta',
        'phoneNumber': '081234567890',
        'gender': 'Laki-laki',
        'email': 'budi.setiawan@example.com',
      });
      debugPrint('Dummy patient added to Firestore');
    } catch (e) {
      debugPrint('Error adding dummy patient: $e');
    }
  }
}