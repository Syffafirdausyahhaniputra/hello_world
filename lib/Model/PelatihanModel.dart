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

// class PelatihanModel {
//   final int? pelatihanId;
//   final String namaPelatihan;
//   final String periode;
//   final DateTime tanggal;
//   final DateTime tanggalAkhir;
//   final int levelId;
//   final int vendorId;
//   final int bidangId;
//   final int mkId;
//   // final String lokasi;
//   // final int? kuota;

//   PelatihanModel({
//     this.pelatihanId,
//     required this.namaPelatihan,
//     required this.periode,
//     required this.tanggal,
//     required this.tanggalAkhir,
//     required this.levelId,
//     required this.vendorId,
//     required this.bidangId,
//     required this.mkId,
//     // required this.lokasi,
//     // this.kuota,
//   });

//   factory PelatihanModel.fromJson(Map<String, dynamic> json) {
//     return PelatihanModel(
//       pelatihanId: json['pelatihan_id'],
//       namaPelatihan: json['nama_pelatihan'],
//       periode: json['periode'],
//       tanggal: DateTime.parse(json['tanggal']),
//       tanggalAkhir: DateTime.parse(json['tanggal_akhir']),
//       levelId: json['level_id'],
//       vendorId: json['vendor_id'],
//       bidangId: json['bidang_id'],
//       mkId: json['mk_id'],
//       // lokasi: json['lokasi'],
//       // kuota: json['kuota'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'pelatihan_id': pelatihanId,
//       'nama_pelatihan': namaPelatihan,
//       'periode': periode,
//       'tanggal': tanggal.toIso8601String(),
//       'tanggal_akhir': tanggalAkhir.toIso8601String(),
//       'level_id': levelId,
//       'vendor_id': vendorId,
//       'bidang_id': bidangId,
//       'mk_id': mkId,
//       // 'lokasi': lokasi,
//       // 'kuota': kuota,
//     };
//   }}
// Model untuk Pelatihan
class PelatihanModel {
  final int? id;
  final String namaPelatihan;
  final String tanggal;
  final String tanggalAkhir;
  final int kuota;
  final String lokasi;
  final String periode;
  // final double biaya;
  final int levelId;
  final int bidangId;
  final int mkId;
  final int vendorId;

  PelatihanModel({
    this.id,
    required this.namaPelatihan,
    required this.tanggal,
    required this.tanggalAkhir,
    required this.kuota,
    required this.lokasi,
    required this.periode,
    // required this.biaya,
    required this.levelId,
    required this.bidangId,
    required this.mkId,
    required this.vendorId,
  });

  factory PelatihanModel.fromJson(Map<String, dynamic> json) {
    return PelatihanModel(
      id: json['id'],
      namaPelatihan: json['nama_pelatihan'],
      tanggal: json['tanggal'],
      tanggalAkhir: json['tanggal_akhir'],
      kuota: json['kuota'],
      lokasi: json['lokasi'],
      periode: json['periode'],
      // biaya: double.parse(json['biaya'].toString()),
      levelId: json['level_id'],
      bidangId: json['bidang_id'],
      mkId: json['mk_id'],
      vendorId: json['vendor_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_pelatihan': namaPelatihan,
      'tanggal': tanggal,
      'tanggal_akhir': tanggalAkhir,
      'kuota': kuota,
      'lokasi': lokasi,
      'periode': periode,
      // 'biaya': biaya,
      'level_id': levelId,
      'bidang_id': bidangId,
      'mk_id': mkId,
      'vendor_id': vendorId,
    };
  }
}
