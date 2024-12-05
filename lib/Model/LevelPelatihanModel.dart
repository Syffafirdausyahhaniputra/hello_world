class LevelPelatihanModel {
  final int levelId;
  final String levelKode;
  final String levelNama;
  final String createdAt;
  final String updatedAt;

  LevelPelatihanModel({
    required this.levelId,
    required this.levelKode,
    required this.levelNama,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory constructor untuk mengonversi JSON ke objek `LevelPelatihanModel`
  factory LevelPelatihanModel.fromJson(Map<String, dynamic> json) {
    return LevelPelatihanModel(
      levelId: json['level_id'] ?? 0,
      levelKode: json['level_kode'] ?? '-',
      levelNama: json['level_nama'] ?? '-',
      createdAt: json['created_at'] ?? '-',
      updatedAt: json['updated_at'] ?? '-',
    );
  }

  /// Metode untuk mengonversi objek `LevelPelatihanModel` ke JSON
  Map<String, dynamic> toJson() {
    return {
      'level_id': levelId,
      'level_kode': levelKode,
      'level_nama': levelNama,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
