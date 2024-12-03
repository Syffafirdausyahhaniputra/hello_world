class JenisModel {
  final int jenisId;
  final String jenisKode;
  final String jenisNama;
  final String createdAt;
  final String updatedAt;

  JenisModel({
    required this.jenisId,
    required this.jenisKode,
    required this.jenisNama,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory constructor untuk mengonversi JSON ke objek `JenisModel`
  factory JenisModel.fromJson(Map<String, dynamic> json) {
    return JenisModel(
      jenisId: json['jenis_id'] ?? 0,
      jenisKode: json['jenis_kode'] ?? '-',
      jenisNama: json['jenis_nama'] ?? '-',
      createdAt: json['created_at'] ?? '-',
      updatedAt: json['updated_at'] ?? '-',
    );
  }

  /// Metode untuk mengonversi objek `JenisModel` ke JSON
  Map<String, dynamic> toJson() {
    return {
      'jenis_id': jenisId,
      'jenis_kode': jenisKode,
      'jenis_nama': jenisNama,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
