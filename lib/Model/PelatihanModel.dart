class PelatihanModel {
  final int id;
  final String namaPelatihan;
  final String bidangPelatihan;
  final String masaBerlaku;
  final int pelatihanId;
  final int levelId;
  final int bidangId;
  final int mkId;
  final int vendorId;
  final String tanggal;
  final String tanggalAkhir;
  final int kuota;
  final String lokasi;
  final String periode;
  final double biaya;

  PelatihanModel({
    required this.id,
    required this.namaPelatihan,
    required this.bidangPelatihan,
    required this.masaBerlaku,
    required this.pelatihanId,
    required this.levelId,
    required this.bidangId,
    required this.mkId,
    required this.vendorId,
    required this.tanggal,
    required this.tanggalAkhir,
    required this.kuota,
    required this.lokasi,
    required this.periode,
    required this.biaya,
  });

  factory PelatihanModel.fromJson(Map<String, dynamic> json) {
    return PelatihanModel(
      id: json['id_pelatihan'] ?? 0,
      namaPelatihan: json['nama_pelatihan'] ?? '-',
      bidangPelatihan: json['bidang_pelatihan'] ?? '-',
      masaBerlaku: json['masa_berlaku'] ?? '-',
      pelatihanId: json['pelatihan_id'] ?? 0,
      levelId: json['level_id'] ?? 0,
      bidangId: json['bidang_id'] ?? 0,
      mkId: json['mk_id'] ?? 0,
      vendorId: json['vendor_id'] ?? 0,
      tanggal: json['tanggal'] ?? '-',
      tanggalAkhir: json['tanggal_akhir'] ?? '-',
      kuota: json['kuota'] ?? 0,
      lokasi: json['lokasi'] ?? '-',
      periode: json['periode'] ?? '-',
      biaya: (json['biaya'] != null) ? double.parse(json['biaya'].toString()) : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pelatihan_id': pelatihanId,
      'level_id': levelId,
      'bidang_id': bidangId,
      'mk_id': mkId,
      'vendor_id': vendorId,
      'nama_pelatihan': namaPelatihan,
      'tanggal': tanggal,
      'tanggal_akhir': tanggalAkhir,
      'kuota': kuota,
      'lokasi': lokasi,
      'periode': periode,
      'biaya': biaya,
    };
  }
}
