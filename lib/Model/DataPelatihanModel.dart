class DataPelatihanModel {
  final int id;
  final int dosenId;
  final String namaPelatihan;
  final String bidangPelatihan;
  final String tanggal;
  final int dataPelatihanId;
  final int pelatihanId;
  final int suratTugasId;
  final String keterangan;
  final String status;
  final String sertifikat;
  final String createdAt;
  final String updatedAt;

  DataPelatihanModel({
    required this.id,
    required this.dosenId,
    required this.namaPelatihan,
    required this.bidangPelatihan,
    required this.tanggal,
    required this.dataPelatihanId,
    required this.pelatihanId,
    required this.suratTugasId,
    required this.keterangan,
    required this.status,
    required this.sertifikat,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DataPelatihanModel.fromJson(Map<String, dynamic> json) {
    return DataPelatihanModel(
      id: json['id_pelatihan'] ?? 0,
      dosenId: json['dosen_id'] ?? 0,
      namaPelatihan: json['nama_pelatihan'] ?? '-',
      bidangPelatihan: json['bidang_pelatihan'] ?? '-',
      tanggal: json['tanggal'] ?? '-',
      dataPelatihanId: json['data_pelatihan_id'] ?? 0,
      pelatihanId: json['pelatihan_id'] ?? 0,
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
      'data_pelatihan_id': dataPelatihanId,
      'pelatihan_id': pelatihanId,
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
