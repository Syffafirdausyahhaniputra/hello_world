class GolonganModel {
  final int golonganId;
  final String golonganNama;

  // Constructor
  GolonganModel({
    required this.golonganId,
    required this.golonganNama,
  });

  factory GolonganModel.fromJson(Map<String, dynamic> json) {
    return GolonganModel(
      golonganId: json['golongan_id'] ?? 0,
      golonganNama: json['golongan_nama'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'golongan_id': golonganId,
      'golongan_nama': golonganNama,
    };
  }
}
