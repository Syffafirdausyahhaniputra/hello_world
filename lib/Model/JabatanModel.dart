class JabatanModel {
  final int jabatanId;
  final String jabatanNama;

  // Constructor
  JabatanModel({
    required this.jabatanId,
    required this.jabatanNama,
  });

  factory JabatanModel.fromJson(Map<String, dynamic> json) {
    return JabatanModel(
      jabatanId: json['jabatan_id'] ?? 0,
      jabatanNama: json['jabatan_nama'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jabatan_id': jabatanId,
      'jabatan_nama': jabatanNama,
    };
  }
}
