class PelatihanModel {
  final int id;
  final String namaPelatihan;
  final String bidangPelatihan;
  final String masaBerlaku;

  PelatihanModel({
    required this.id,
    required this.namaPelatihan,
    required this.bidangPelatihan,
    required this.masaBerlaku,
  });

  factory PelatihanModel.fromJson(Map<String, dynamic> json) {
    return PelatihanModel(
      id: json['id_pelatihan'] ?? 0,
      namaPelatihan: json['nama_pelatihan'] ?? '-',
      bidangPelatihan: json['bidang_pelatihan'] ?? '-',
      masaBerlaku: json['masa_berlaku'] ?? '-',
    );
  }
}
