class PelatihanModel {
  final String namaPelatihan;
  final String bidangPelatihan;
  final String masaBerlaku;

  PelatihanModel({
    required this.namaPelatihan,
    required this.bidangPelatihan,
    required this.masaBerlaku,
  });

  factory PelatihanModel.fromJson(Map<String, dynamic> json) {
    return PelatihanModel(
      namaPelatihan: json['nama_pelatihan'] ?? '-',
      bidangPelatihan: json['bidang_pelatihan'] ?? '-',
      masaBerlaku: json['masa_berlaku'] ?? '-',
    );
  }
}
