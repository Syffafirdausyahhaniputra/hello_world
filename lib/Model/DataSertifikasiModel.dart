class DataSertifikasiModel {
  final int id;
  final int dosenId;
  final String namaSertifikasi;
  final String bidangSertifikasi;
  final String masaBerlaku;
  final int dataSertifId;
  final int sertifId;
  final int suratTugasId;
  final String keterangan;
  final String status;
  final String sertifikat;
  final String createdAt;
  final String updatedAt;

  DataSertifikasiModel({
    required this.id,
    required this.dosenId,
    required this.namaSertifikasi,
    required this.bidangSertifikasi,
    required this.masaBerlaku,
    required this.dataSertifId,
    required this.sertifId,
    required this.suratTugasId,
    required this.keterangan,
    required this.status,
    required this.sertifikat,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DataSertifikasiModel.fromJson(Map<String, dynamic> json) {
    return DataSertifikasiModel(
      id: json['id_sertifikasi'] ?? 0,
      dosenId: json['dosen_id'] ?? 0,
      namaSertifikasi: json['nama_sertifikasi'] ?? '-',
      bidangSertifikasi: json['bidang_sertifikasi'] ?? '-',
      masaBerlaku: json['masa_berlaku'] ?? '-',
      dataSertifId: json['data_sertif_id'] ?? 0,
      sertifId: json['sertif_id'] ?? 0,
      suratTugasId: json['surat_tugas_id'] ?? 0,
      keterangan: json['keterangan'] ?? '-',
      status: json['status'] ?? '-',
      sertifikat: json['sertifikat'] ?? '-',
      createdAt: json['created_at'] ?? '-',
      updatedAt: json['updated_at'] ?? '-',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data_sertif_id': dataSertifId,
      'sertif_id': sertifId,
      'dosen_id': dosenId,
      'surat_tugas_id': suratTugasId,
      'keterangan': keterangan,
      'status': status,
      'sertifikat': sertifikat,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
