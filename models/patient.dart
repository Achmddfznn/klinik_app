/// Model untuk data pasien
/// 
/// Kelas ini menyimpan informasi tentang pasien seperti id, nama,
/// alamat, nomor telepon, jenis kelamin, dan email.
class Patient {
  final String id;
  final String name;
  final String address;
  final String phoneNumber;
  final String gender;
  final String email;

  /// Constructor untuk membuat objek Patient
  /// 
  /// Semua parameter wajib diisi
  const Patient({
    required this.id,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.gender,
    required this.email,
  });
  
  /// Factory constructor untuk membuat Patient dari JSON
  /// 
  /// Parameter [json] adalah Map yang berisi data pasien dalam format JSON
  /// Returns [Patient] yang dibuat dari data JSON
  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      phoneNumber: json['phoneNumber'] as String,
      gender: json['gender'] as String,
      email: json['email'] as String,
    );
  }
  
  /// Metode untuk mengkonversi Patient ke JSON
  /// 
  /// Returns [Map<String, dynamic>] yang berisi data pasien dalam format JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'email': email,
    };
  }
}