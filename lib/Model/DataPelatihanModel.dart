class DataPelatihanModel {
  final int id;
  final int dosenId;
  final String namaPelatihan;
  final String bidangPelatihan;
  final String tanggal;

  DataPelatihanModel({
    required this.id,
    required this.dosenId,
    required this.namaPelatihan,
    required this.bidangPelatihan,
    required this.tanggal,
  });

  factory DataPelatihanModel.fromJson(Map<String, dynamic> json) {
    return DataPelatihanModel(
      id: json['id_pelatihan'] ?? 0,
      dosenId: json['dosen_id'] ?? 0,
      namaPelatihan: json['nama_pelatihan'] ?? '-',
      bidangPelatihan: json['bidang_pelatihan'] ?? '-',
      tanggal: json['tanggal'] ?? '-',
    );
  }
}
