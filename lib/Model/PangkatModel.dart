class PangkatModel {
  final int pangkatId;
  final String pangkatNama;

  // Constructor
  PangkatModel({
    required this.pangkatId,
    required this.pangkatNama,
  });

  factory PangkatModel.fromJson(Map<String, dynamic> json) {
    return PangkatModel(
      pangkatId: json['pangkat_id'] ?? 0,
      pangkatNama: json['pangkat_nama'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pangkat_id': pangkatId,
      'pangkat_nama': pangkatNama,
    };
  }
}
