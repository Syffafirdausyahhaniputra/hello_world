class BidangModel {
  final int bidangId;
  final String bidangKode;
  final String bidangNama;

  // Constructor
  BidangModel({
    required this.bidangId,
    required this.bidangKode,
    required this.bidangNama,
  });

  factory BidangModel.fromJson(Map<String, dynamic> json) {
    final bidang = json['bidang'] ?? {}; // Akses objek 'bidang' di dalam data
    return BidangModel(
      bidangId: bidang['bidang_id'] ?? 0,
      bidangKode: bidang['bidang_kode'] ?? '',
      bidangNama: bidang['bidang_nama'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bidang_id': bidangId,
      'bidang_kode': bidangKode,
      'bidang_nama': bidangNama,
    };
  }
}
