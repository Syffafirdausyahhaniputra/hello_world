class SertifikasiModel {
  final int id;
  final String namaSertifikasi;
  final String bidangSertifikasi;
  final String masaBerlaku;
  final int sertifId;
  final int jenisId;
  final int bidangId;
  final int mkId;
  final int vendorId;
  final String namaSertif;
  final String tanggal;
  final String tanggalAkhir;
  final double biaya;
  final String periode;
  final String createdAt;
  final String updatedAt;

  SertifikasiModel({
    required this.id,
    required this.namaSertifikasi,
    required this.bidangSertifikasi,
    required this.masaBerlaku,
    required this.sertifId,
    required this.jenisId,
    required this.bidangId,
    required this.mkId,
    required this.vendorId,
    required this.namaSertif,
    required this.tanggal,
    required this.tanggalAkhir,
    required this.biaya,
    required this.periode,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SertifikasiModel.fromJson(Map<String, dynamic> json) {
    return SertifikasiModel(
      id: json['id_sertifikasi'] ?? 0,
      namaSertifikasi: json['nama_sertifikasi'] ?? '-',
      bidangSertifikasi: json['bidang_sertifikasi'] ?? '-',
      masaBerlaku: json['masa_berlaku'] ?? '-',
      sertifId: json['sertif_id'] ?? 0,
      jenisId: json['jenis_id'] ?? 0,
      bidangId: json['bidang_id'] ?? 0,
      mkId: json['mk_id'] ?? 0,
      vendorId: json['vendor_id'] ?? 0,
      namaSertif: json['nama_sertif'] ?? '-',
      tanggal: json['tanggal'] ?? '-',
      tanggalAkhir: json['tanggal_akhir'] ?? '-',
      biaya: (json['biaya'] != null) ? double.parse(json['biaya'].toString()) : 0.0,
      periode: json['periode'] ?? '-',
      createdAt: json['created_at'] ?? '-',
      updatedAt: json['updated_at'] ?? '-',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sertif_id': sertifId,
      'jenis_id': jenisId,
      'bidang_id': bidangId,
      'mk_id': mkId,
      'vendor_id': vendorId,
      'nama_sertif': namaSertif,
      'tanggal': tanggal,
      'masa_berlaku': masaBerlaku,
      'tanggal_akhir': tanggalAkhir,
      'biaya': biaya,
      'periode': periode,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
