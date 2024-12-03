// class PelatihanModel {
//   final int id;
//   final String namaPelatihan;
//   final String bidangPelatihan;
//   final String masaBerlaku;

//   PelatihanModel({
//     required this.id,
//     required this.namaPelatihan,
//     required this.bidangPelatihan,
//     required this.masaBerlaku,
//   });

//   factory PelatihanModel.fromJson(Map<String, dynamic> json) {
//     return PelatihanModel(
//       id: json['id_pelatihan'] ?? 0,
//       namaPelatihan: json['nama_pelatihan'] ?? '-',
//       bidangPelatihan: json['bidang_pelatihan'] ?? '-',
//       masaBerlaku: json['masa_berlaku'] ?? '-',
//     );
//   }
// }

class PelatihanModel {
  final int pelatihanId;
  final int levelId;
  final int bidangId;
  final int mkId;
  final int vendorId;
  final String namaPelatihan;
  final DateTime tanggal;
  final DateTime tanggalAkhir;
  // final int kuota;
  // final String lokasi;
  final String periode;


  // Konstruktor
  PelatihanModel({
    required this.pelatihanId,
    required this.levelId,
    required this.bidangId,
    required this.mkId,
    required this.vendorId,
    required this.namaPelatihan,
    required this.tanggal,
    required this.tanggalAkhir,
    // required this.kuota,
    // required this.lokasi,
    required this.periode,
  });

  // Factory untuk parsing dari JSON
  factory PelatihanModel.fromJson(Map<String, dynamic> json) {
    return PelatihanModel(
      pelatihanId: json['pelatihan_id'] ?? '-',
      levelId: json['level_id']?? '-',
      bidangId: json['bidang_id'] ?? '-',
      mkId: json['mk_id'] ?? '-',
      vendorId: json['vendor_id'] ?? '-',
      namaPelatihan: json['nama_pelatihan']?? '-' ,
      tanggal: json['tanggal']?? '-' ,
      tanggalAkhir: json['tanggal_akhir']?? '-' ,
      // kuota: json['kuota']?? '-' ,
      // lokasi: json['lokasi']?? '-' ,
      periode: json['periode']?? '-' ,
    );
  }

  // Fungsi untuk mengubah ke JSON (misalnya untuk dikirim ke API)
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
      // 'kuota': kuota,
      // 'lokasi': lokasi,
      'periode': periode,

    };
  }
}
