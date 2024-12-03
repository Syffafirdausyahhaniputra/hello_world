class SuratTugasModel {
  int? suratTugasId;
  String? nomorSurat;
  String? namaSurat;
  DateTime? createdAt;
  DateTime? updatedAt;

  SuratTugasModel({
    this.suratTugasId,
    this.nomorSurat,
    this.namaSurat,
    this.createdAt,
    this.updatedAt,
  });

  // Factory constructor to create an instance from a JSON object
  factory SuratTugasModel.fromJson(Map<String, dynamic> json) {
    return SuratTugasModel(
      suratTugasId: json['surat_tugas_id'],
      nomorSurat: json['nomor_surat'],
      namaSurat: json['nama_surat'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  // Method to convert an instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'surat_tugas_id': suratTugasId,
      'nomor_surat': nomorSurat,
      'nama_surat': namaSurat,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
