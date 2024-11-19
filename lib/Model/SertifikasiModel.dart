class SertifikasiModel {
  final String namaSertifikasi;
  final String bidangSertifikasi;
  final String masaBerlaku;

  SertifikasiModel({
    required this.namaSertifikasi,
    required this.bidangSertifikasi,
    required this.masaBerlaku,
  });

  factory SertifikasiModel.fromJson(Map<String, dynamic> json) {
    return SertifikasiModel(
      namaSertifikasi: json['nama_sertifikasi'] ?? '-',
      bidangSertifikasi: json['bidang_sertifikasi'] ?? '-',
      masaBerlaku: json['masa_berlaku'] ?? '-',
    );
  }
}
