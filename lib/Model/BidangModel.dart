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

  // Factory method to create BidangModel from JSON
  factory BidangModel.fromJson(Map<String, dynamic> json) {
    return BidangModel(
      bidangId: json['bidang_id'] as int,
      bidangKode: json['bidang_kode'] as String,
      bidangNama: json['bidang_nama'] as String,
    );
  }

  // Method to convert BidangModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'bidang_id': bidangId,
      'bidang_kode': bidangKode,
      'bidang_nama': bidangNama,
    };
  }
}
