/// Model data untuk dokter
///
/// Kelas ini merepresentasikan data dokter dengan informasi seperti
/// identitas, nama, spesialisasi, dan jadwal praktik.
class Doctor {
  /// ID unik dokter
  final String id;
  
  /// Nama lengkap dokter
  final String name;
  
  /// Spesialisasi atau bidang keahlian dokter
  final String specialty;
  
  /// Hari jadwal praktik dokter
  final String scheduleDay;
  
  /// Waktu jadwal praktik dokter
  final String scheduleTime;

  /// Constructor untuk membuat objek Doctor
  /// 
  /// Semua parameter bersifat required (wajib diisi)
  const Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.scheduleDay,
    required this.scheduleTime,
  });
  
  /// Factory constructor untuk membuat objek Doctor dari JSON
  /// 
  /// [json] adalah Map yang berisi data dokter dari API atau penyimpanan lokal
  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'] as String,
      name: json['name'] as String,
      specialty: json['specialty'] as String,
      scheduleDay: json['scheduleDay'] as String,
      scheduleTime: json['scheduleTime'] as String,
    );
  }
  
  /// Metode untuk mengkonversi objek Doctor ke format JSON
  /// 
  /// Mengembalikan Map yang dapat digunakan untuk penyimpanan atau pengiriman data
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialty': specialty,
      'scheduleDay': scheduleDay,
      'scheduleTime': scheduleTime,
    };
  }
}