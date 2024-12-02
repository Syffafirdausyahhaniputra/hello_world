class MatkulModel {
  final int mkId;
  final String mkKode;
  final String mkNama;

  // Constructor
  MatkulModel({
    required this.mkId,
    required this.mkKode,
    required this.mkNama,
  });

  // Factory method to create MatkulModel from JSON
  factory MatkulModel.fromJson(Map<String, dynamic> json) {
    return MatkulModel(
      mkId: json['mk_id'] ?? 0,
      mkKode: json['mk_kode'] ?? '',
      mkNama: json['mk_nama'] ?? '',
    );
  }

  // Method to convert MatkulModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'mk_id': mkId,
      'mk_kode': mkKode,
      'mk_nama': mkNama,
    };
  }
}
