class VendorModel {
  int? vendorId;
  String? vendorNama;
  String? vendorAlamat;
  String? vendorKota;
  String? vendorNoTelf;
  String? vendorAlamatWeb;
  DateTime? createdAt;
  DateTime? updatedAt;

  VendorModel({
    this.vendorId,
    this.vendorNama,
    this.vendorAlamat,
    this.vendorKota,
    this.vendorNoTelf,
    this.vendorAlamatWeb,
    this.createdAt,
    this.updatedAt,
  });

  // Factory constructor to create an instance from a JSON object
  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      vendorId: json['vendor_id'],
      vendorNama: json['vendor_nama'],
      vendorAlamat: json['vendor_alamat'],
      vendorKota: json['vendor_kota'],
      vendorNoTelf: json['vendor_no_telf'],
      vendorAlamatWeb: json['vendor_alamat_web'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  // Method to convert an instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'vendor_id': vendorId,
      'vendor_nama': vendorNama,
      'vendor_alamat': vendorAlamat,
      'vendor_kota': vendorKota,
      'vendor_no_telf': vendorNoTelf,
      'vendor_alamat_web': vendorAlamatWeb,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
