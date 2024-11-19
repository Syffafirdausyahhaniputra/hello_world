class DataSertifikasiModel {
  final int id;
  final int dosenId;
  final String namaSertifikasi;
  final String bidangSertifikasi;
  final String masaBerlaku;

  DataSertifikasiModel({
    required this.id,
    required this.dosenId,
    required this.namaSertifikasi,
    required this.bidangSertifikasi,
    required this.masaBerlaku,
  });

  factory DataSertifikasiModel.fromJson(Map<String, dynamic> json) {
    return DataSertifikasiModel(
      id: json['id'] ?? 0,
      dosenId: json['dosen_id'] ?? 0,
      namaSertifikasi: json['nama_sertifikasi'] ?? '-',
      bidangSertifikasi: json['bidang_sertifikasi'] ?? '-',
      masaBerlaku: json['masa_berlaku'] ?? '-',
    );
  }
}
