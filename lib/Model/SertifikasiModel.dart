class SertifikasiModel {
  final int id;
  final String namaSertifikasi;
  final String bidangSertifikasi;
  final String masaBerlaku;

  SertifikasiModel({
    required this.id,
    required this.namaSertifikasi,
    required this.bidangSertifikasi,
    required this.masaBerlaku,
  });

  factory SertifikasiModel.fromJson(Map<String, dynamic> json) {
    return SertifikasiModel(
      id: json['id_sertifikasi'] ?? 0,
      namaSertifikasi: json['nama_sertifikasi'] ?? '-',
      bidangSertifikasi: json['bidang_sertifikasi'] ?? '-',
      masaBerlaku: json['masa_berlaku'] ?? '-',
    );
  }
}
