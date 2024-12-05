class KompetensiProdi {
  final int prodiId;
  final String prodiNama;
  final int totalBidang;

  KompetensiProdi({
    required this.prodiId,
    required this.prodiNama,
    required this.totalBidang,
  });

  factory KompetensiProdi.fromJson(Map<String, dynamic> json) {
    return KompetensiProdi(
      prodiId: json['prodi_id'],
      prodiNama: json['prodi_nama'],
      totalBidang: json['total_bidang'] ?? 0,
    );
  }
}
